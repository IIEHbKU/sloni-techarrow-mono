from datetime import date
import random
import uuid

from sqlalchemy import select, delete, union_all
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.ext.asyncio import AsyncSession

from internal.tasks.models.completed_tasks import CompletedTaskModel
from internal.tasks.models.multifaceted_tasks import MultifacetedTaskModel
from internal.tasks.models.unplanned_tasks import UnplannedTaskModel
from internal.tasks.models.planned_tasks import PlannedTaskModel
from internal.tasks.schemes.tasks import (TaskCreateRs, TaskCreateRq, TaskToPlanRq, TaskToPlanRs, TaskListDateRs,
                                          TaskListDate, TaskListRs, TaskList, TaskGetRs)
from pkg.exceptions import CustomException


class TaskRepository:
    def __init__(
            self,
            db_session: AsyncSession
    ):
        self.db_session = db_session

    async def create_task(
            self,
            user_id: str,
            task: TaskCreateRq
    ) -> TaskCreateRs:
        if task.type == "unplanned":
            print(task.category.value)
            stmt = insert(UnplannedTaskModel).values(
                id=int(str(uuid.uuid4().int)[:9]),
                user_id=user_id,
                name=task.name,
                description=task.description,
                category=task.category.value,
                duration=task.duration,
                importance=task.importance,
                is_multi=False
            ).returning(UnplannedTaskModel.id)
            result = await self.db_session.execute(stmt)
            task_id = result.scalar()
            await self.db_session.commit()
            return TaskCreateRs(
                task_id=task_id
            )
        elif task.type == "multifaceted":
            stmt = insert(MultifacetedTaskModel).values(
                id=int(str(uuid.uuid4().int)[:9]),
                user_id=user_id,
                name=task.name,
                description=task.description,
                category=task.category.value,
                importance=task.importance,
                color="#{:06x}".format(random.randint(0, 0xFFFFFF))
            ).returning(MultifacetedTaskModel.id)
            result = await self.db_session.execute(stmt)
            task_id = result.scalar()
            await self.db_session.commit()
            for subtask in task.subtasks:
                stmt = insert(UnplannedTaskModel).values(
                    id=int(str(uuid.uuid4().int)[:9]),
                    user_id=user_id,
                    name=subtask.name,
                    category=task.category.value,
                    duration=subtask.duration,
                    importance=task.importance,
                    is_multi=True,
                    multi_id=task_id
                )
                await self.db_session.execute(stmt)
            await self.db_session.commit()
            return TaskCreateRs(
                task_id=task_id
            )

    async def to_planned(
            self,
            user_id: str,
            task: TaskToPlanRq
    ) -> TaskToPlanRs:

        for task_id in task.tasks:
            stmt_select = select(UnplannedTaskModel).where(
                UnplannedTaskModel.id == task_id,
                UnplannedTaskModel.user_id == user_id
            )
            unplanned_task = await self.db_session.scalar(stmt_select)

            if not unplanned_task:
                continue

            stmt_insert = insert(PlannedTaskModel).values(
                id=unplanned_task.id,
                user_id=unplanned_task.user_id,
                name=unplanned_task.name,
                description=unplanned_task.description,
                category=unplanned_task.category,
                duration=unplanned_task.duration,
                importance=unplanned_task.importance,
                date=task.date,  # Обновляем дату
                is_multi=unplanned_task.is_multi,
                multi_id=unplanned_task.multi_id
            )
            await self.db_session.execute(stmt_insert)

            stmt_delete = delete(UnplannedTaskModel).where(
                UnplannedTaskModel.id == task_id,
                UnplannedTaskModel.user_id == user_id
            )
            await self.db_session.execute(stmt_delete)

        await self.db_session.commit()
        return TaskToPlanRs(status="OK")

    async def get_by_date(
            self,
            user_id: str,
            date: date
    ) -> TaskListDateRs:
        stmt = select(PlannedTaskModel).where(
            PlannedTaskModel.user_id == user_id,
            PlannedTaskModel.date == date
        )
        planned_tasks = await self.db_session.scalars(stmt)
        planned_tasks = [TaskListDate(id=task.id, name=task.name) for task in planned_tasks]

        stmt = select(CompletedTaskModel).where(
            CompletedTaskModel.user_id == user_id,
            CompletedTaskModel.date == date
        )
        completed_tasks = await self.db_session.scalars(stmt)
        completed_tasks = [TaskListDate(id=task.id, name=task.name) for task in completed_tasks]
        return TaskListDateRs(
            planned_tasks=planned_tasks,
            completed_tasks=completed_tasks
        )

    async def to_completed(
            self,
            user_id: str,
            task_id: int
    ) -> TaskToPlanRs:
        stmt = select(PlannedTaskModel).where(
            PlannedTaskModel.id == task_id,
            PlannedTaskModel.user_id == user_id
        )
        planned_task = await self.db_session.scalar(stmt)

        if not planned_task:
            return TaskToPlanRs(status="Task not found")

        stmt_insert = insert(CompletedTaskModel).values(
            id=planned_task.id,
            user_id=planned_task.user_id,
            name=planned_task.name,
            description=planned_task.description,
            category=planned_task.category,
            duration=planned_task.duration,
            importance=planned_task.importance,
            date=planned_task.date,
            is_multi=planned_task.is_multi,
            multi_id=planned_task.multi_id
        )
        await self.db_session.execute(stmt_insert)

        stmt_delete = delete(PlannedTaskModel).where(
            PlannedTaskModel.id == task_id,
            PlannedTaskModel.user_id == user_id
        )
        await self.db_session.execute(stmt_delete)

        await self.db_session.commit()
        return TaskToPlanRs(status="OK")

    async def delete_task(
            self,
            user_id: str,
            task_id: int
    ) -> TaskToPlanRs:
        stmt = delete(PlannedTaskModel).where(
            PlannedTaskModel.id == task_id,
            PlannedTaskModel.user_id == user_id
        )
        await self.db_session.execute(stmt)
        await self.db_session.commit()
        return TaskToPlanRs(status="OK")

    async def get_unplanned(
            self,
            user_id: str
    ) -> TaskListRs:
        stmt = select(UnplannedTaskModel).where(UnplannedTaskModel.user_id == user_id).order_by(
            UnplannedTaskModel.created_at.desc())
        unplanned_tasks = await self.db_session.scalars(stmt)
        unplanned_tasks = [TaskList(id=task.id, name=task.name, description=task.description, duration=task.duration) for task in
                           unplanned_tasks]
        return TaskListRs(tasks=unplanned_tasks)

    async def get_planned(
            self,
            user_id: str
    ) -> TaskListRs:
        stmt = select(PlannedTaskModel).where(PlannedTaskModel.user_id == user_id).order_by(
            PlannedTaskModel.created_at.desc())
        planned_tasks = await self.db_session.scalars(stmt)
        planned_tasks = [TaskList(id=task.id, name=task.name, description=task.description, duration=task.duration) for task in
                         planned_tasks]
        return TaskListRs(tasks=planned_tasks)

    async def get_completed(
            self,
            user_id: str
    ) -> TaskListRs:
        stmt = select(CompletedTaskModel).where(CompletedTaskModel.user_id == user_id).order_by(
            CompletedTaskModel.created_at.desc())
        completed_tasks = await self.db_session.scalars(stmt)
        completed_tasks = [TaskList(id=task.id, name=task.name, description=task.description, duration=task.duration) for task in
                           completed_tasks]
        return TaskListRs(tasks=completed_tasks)

    async def get_by_id(
            self,
            user_id: str,
            task_id: int
    ) -> TaskGetRs:
        planned_query = select(
            PlannedTaskModel
        ).where(
            PlannedTaskModel.id == task_id,
            PlannedTaskModel.user_id == user_id
        )
        unplanned_query = select(
            UnplannedTaskModel
        ).where(
            UnplannedTaskModel.id == task_id,
            UnplannedTaskModel.user_id == user_id
        )
        completed_query = select(
            CompletedTaskModel
        ).where(
            CompletedTaskModel.id == task_id,
            CompletedTaskModel.user_id == user_id
        )
        union_query = union_all(planned_query, unplanned_query, completed_query)
        result = await self.db_session.execute(union_query)
        task = result.one_or_none()
        if not task:
            raise CustomException(code=404, status="error", message="Task not found")
        if task.is_multi:
            multi = select(MultifacetedTaskModel).where(MultifacetedTaskModel.id == task.multi_id)
            m = await self.db_session.scalar(multi)
            m = result.one_or_none()
            color = m.color
            name = m.name
            description = m.description
        else:
            color = None
            name = None
            description = None
        return TaskGetRs(
            id=task.id,
            name=task.name,
            description=task.description,
            category=task.category,
            duration=task.duration,
            importance=task.importance,
            is_multi=task.is_multi,
            multi_id=task.multi_id,
            multi_color=color,
            multi_name=name,
            multi_description=description
        )
