import random
from sqlalchemy.ext.asyncio import AsyncSession

from infra.llama3.access import Llama3Client
from internal.advice.schemes.advice import AdviceCreateRs, AdviceGetRs, AdviceCreateRq
from internal.advice.repository.repository import AdviceRepository


class AdviceUsecase:
    def __init__(
            self,
            db_session: AsyncSession,
            llama3_client: 'Llama3Client'
    ):
        self.repo = AdviceRepository(db_session)
        self.llama3_client = llama3_client

    async def create_advice(
            self,
            user_id: str,
            ids: AdviceCreateRq
    ) -> AdviceCreateRs:
        print(ids)
        info = await self.repo.get_info(user_id, ids)
        text = await self.llama3_client.send_request(info)
        color = "#{:06x}".format(random.randint(0, 0xFFFFFF))
        return await self.repo.create_advice(user_id, text, color)

    async def get_advice(
            self,
            user_id: str
    ) -> AdviceGetRs:
        return await self.repo.get_advice(user_id)
