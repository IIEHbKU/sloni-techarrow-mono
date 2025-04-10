from datetime import date

from sqlalchemy.ext.asyncio import AsyncSession

from internal.fields.schemes.fields import FieldInput, FieldAnswer
from internal.fields.repository.repository import FieldRepository


class FieldUsecase:
    def __init__(
            self,
            db_session: AsyncSession
    ):
        self.repo = FieldRepository(db_session)

    async def update_field(
            self,
            user_id: str,
            field: FieldInput
    ) -> FieldAnswer:
        return await self.repo.update_field(user_id, field)

    async def get_field(
            self,
            user_id: str,
            date: date
    ) -> FieldAnswer:
        return await self.repo.get_field(user_id, date)
