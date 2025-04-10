import httpx
from pydantic import BaseModel

from infra.logger import logger
from infra.settings import settings


class Message(BaseModel):
    model: str
    prompt: str
    stream: bool


class Response(BaseModel):
    model: str
    response: str
    done: bool


class Llama3Client:
    api_url: str | None = None

    @classmethod
    async def init_client(
            cls
    ) -> None:
        if cls.api_url is not None:
            logger.error("Llama3 is already initialized")
            return None

        cls.api_url = settings.llama3_api_url
        logger.info("Llama3 initialized")

    @classmethod
    async def close_client(
            cls
    ) -> None:
        if cls.api_url is not None:
            cls.api_url = None
        logger.info("Llama3 closed")

    @classmethod
    async def send_request(
            cls,
            data: str,
    ) -> str:
        print("йоу")
        async with httpx.AsyncClient() as client:

            rs = await client.get(cls.api_url, params={"data": data})

            logger.info("Response: %s", rs.text.encode('utf-8'))

            # Проверяем статус
            if rs.status_code != 200:
                raise Exception(f"Request failed with status code {rs.status_code}: {rs.text}")

            return rs.text

    @classmethod
    def get_instance(
            cls
    ) -> 'Llama3Client':
        return cls()
