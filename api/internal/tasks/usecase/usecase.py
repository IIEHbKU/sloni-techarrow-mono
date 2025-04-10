from datetime import date
from sqlalchemy.ext.asyncio import AsyncSession

from internal.tasks.schemes.tasks import TaskCreateRs, TaskCreateRq, TaskToPlanRq, TaskToPlanRs, TaskListDateRs, \
    TaskListRs, TaskGetRs

from internal.tasks.repository.repository import TaskRepository


class TaskUsecase:
    def __init__(
            self,
            db_session: AsyncSession
    ):
        self.repo = TaskRepository(db_session)

    async def create_task(
            self,
            user_id: str,
            task: TaskCreateRq
    ) -> TaskCreateRs:
        return await self.repo.create_task(user_id, task)

    async def to_planned(
            self,
            user_id: str,
            tasks: TaskToPlanRq
    ) -> TaskToPlanRs:
        return await self.repo.to_planned(user_id, tasks)

    async def get_by_date(
            self,
            user_id: str,
            date: date
    ) -> TaskListDateRs:
        return await self.repo.get_by_date(user_id, date)

    async def to_completed(
            self,
            user_id: str,
            task_id: int
    ) -> TaskToPlanRs:
        return await self.repo.to_completed(user_id, task_id)

    async def delete_task(
            self,
            user_id: str,
            task_id: int
    ) -> TaskToPlanRs:
        return await self.repo.delete_task(user_id, task_id)

    async def get_unplanned(
            self,
            user_id: str
    ) -> TaskListRs:
        return await self.repo.get_unplanned(user_id)

    async def get_planned(
            self,
            user_id: str
    ) -> TaskListRs:
        return await self.repo.get_planned(user_id)

    async def get_completed(
            self,
            user_id: str
    ) -> TaskListRs:
        return await self.repo.get_completed(user_id)

    async def get_by_id(
            self,
            user_id: str,
            task_id: int
    ) -> TaskGetRs:
        return await self.repo.get_by_id(user_id, task_id)
