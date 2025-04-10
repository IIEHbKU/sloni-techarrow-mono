from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.dialects.postgresql import insert

from internal.advice.schemes.advice import AdviceCreateRs, AdviceGetRs, AdviceCreateRq
from internal.advice.models.advice import AdviceModel
from internal.tasks.models.planned_tasks import PlannedTaskModel


class AdviceRepository:
    def __init__(
            self,
            db_session: AsyncSession
    ):
        self.db_session = db_session

    async def get_info(
            self,
            user_id: str,
            ids: AdviceCreateRq
    ):
        results = []
        for id in ids.ids:
            stmt = select(PlannedTaskModel).where(PlannedTaskModel.id == id, PlannedTaskModel.user_id == user_id)
            result = await self.db_session.execute(stmt)
            task = result.scalar()
            if task:
                results.append(f"| {task.name}:{task.description} |")
        await self.db_session.commit()
        return "\n".join(results)

    async def create_advice(
            self,
            user_id: str,
            text: str,
            color: str
    ) -> AdviceCreateRs:
        stmt = insert(AdviceModel).values(
            user_id=user_id,
            text=text,
            color=color
        ).returning(AdviceModel.id)
        result = await self.db_session.execute(stmt)
        advice_id = result.scalar()
        await self.db_session.commit()
        return AdviceCreateRs(
            id=advice_id,
            text=text,
            color=color
        )

    async def get_advice(
            self,
            user_id: str,
    ) -> AdviceCreateRs:
        stmt = select(AdviceModel).where(AdviceModel.user_id == user_id)
        result = await self.db_session.execute(stmt)
        rs_dict = []
        for advice in result.scalars():
            rs_dict.append(AdviceCreateRs(
                id=advice.id,
                text=advice.text,
                color=advice.color
            ))
        return AdviceGetRs(
            advice=rs_dict
        )
