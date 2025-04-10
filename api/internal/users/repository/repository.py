from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.dialects.postgresql import insert

from internal.users.models.users import UserModel
from internal.users.schemes.users import UserRegisterRq, UserRegisterRs


class UserRepository:
    def __init__(
            self,
            db_session: AsyncSession
    ):
        self.db_session = db_session

    async def register_user(
            self,
            user: UserRegisterRq
    ) -> UserRegisterRs:
        stmt = insert(UserModel).values(
            id=user.id,
            name=user.userName,
            email=user.email
        )
        await self.db_session.execute(stmt)
        await self.db_session.commit()
        return UserRegisterRs(
            status="OK"
        )
