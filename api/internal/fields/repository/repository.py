from datetime import date

from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession

from internal.fields.models.fields import FieldModel
from internal.fields.schemes.fields import FieldInput, FieldAnswer, FieldOutput, TaskCategory, TaskInfo
from internal.tasks.models.multifaceted_tasks import MultifacetedTaskModel
from internal.tasks.models.planned_tasks import PlannedTaskModel
from pkg.exceptions import CustomException


class FieldRepository:
    def __init__(
            self,
            db_session: AsyncSession
    ):
        self.db_session = db_session

    async def update_field(
            self,
            user_id: str,
            field: FieldInput
    ) -> FieldAnswer:
        stmt = select(FieldModel).where(
            FieldModel.user_id == user_id,
            FieldModel.date == field.date
        )
        result = await self.db_session.execute(stmt)
        existing_field = result.scalar_one_or_none()
        if existing_field:
            stmt = (
                update(FieldModel)
                .where(
                    FieldModel.user_id == user_id,
                    FieldModel.date == field.date
                )
                .values(matrix=field.list)
            )
            await self.db_session.execute(stmt)
            message = "Field updated successfully."
        else:
            new_field = FieldModel(
                date=field.date,
                user_id=user_id,
                matrix=field.list
            )
            self.db_session.add(new_field)
            message = "Field created successfully."

        await self.db_session.commit()

        return FieldAnswer(
            status=message
        )

    async def get_field(
            self,
            user_id: str,
            date: date
    ) -> FieldAnswer:
        stmt = select(FieldModel).where(
            FieldModel.user_id == user_id,
            FieldModel.date == date
        )
        result = await self.db_session.execute(stmt)
        field = result.scalar_one_or_none()
        if not field:
            raise CustomException(code=404, status="error", message="Field not found")
        matrix = field.matrix
        task_ids = []
        for row in matrix:
            task_ids.extend([element for element in row if element != "0"])
        tasks_info = []
        for task_id in task_ids:
            task_stmt = select(PlannedTaskModel).where(PlannedTaskModel.id == task_id)
            task_result = await self.db_session.execute(task_stmt)
            task = task_result.scalar_one_or_none()
            if task:
                multi_color = None
                multi_name = None
                multi_description = None
                if task.multi_id:
                    multi_task_stmt = select(MultifacetedTaskModel).where(
                        MultifacetedTaskModel.id == task.multi_id
                    )
                    multi_task_result = await self.db_session.execute(multi_task_stmt)
                    multi_task = multi_task_result.scalar_one_or_none()
                    if multi_task:
                        multi_color = multi_task.color
                        multi_name = multi_task.name
                        multi_description = multi_task.description
                tasks_info.append(TaskInfo(
                    id=task.id,
                    name=task.name,
                    description=task.description,
                    category=TaskCategory(task.category),
                    duration=task.duration,
                    importance=task.importance,
                    is_multi=task.is_multi,
                    multi_id=task.multi_id,
                    multi_color=multi_color,
                    multi_name=multi_name,
                    multi_description=multi_description
                ))
        return FieldOutput(
            date=field.date,
            matrix=matrix,
            info=tasks_info
        )
