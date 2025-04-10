from typing import Dict

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from infra.keycloak_.access import authenticate
from infra.postgres.access import get_async_session
from infra.llama3.access import Llama3Client, get_llama3_client
from pkg.exceptions import handle_exception
from internal.advice.schemes.advice import AdviceCreateRs, AdviceCreateRq, AdviceGetRs
from internal.advice.usecase.usecase import AdviceUsecase

router = APIRouter(
    prefix="/api/advice",
    tags=["Advice"]
)


@router.post(
    "/create",
    status_code=200,
    response_model=AdviceCreateRs,
)
async def create_advice(
        ids: AdviceCreateRq,
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session),
        llama3_client: Llama3Client = Depends(get_llama3_client)
) -> AdviceCreateRs:
    advice_usecase = AdviceUsecase(db_session, llama3_client)
    advice = await advice_usecase.create_advice(user_id["user_id"], ids)
    return advice


@router.get(
    "/get",
    status_code=200,
    response_model=AdviceGetRs,
)
async def get_advice(
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> AdviceGetRs:
    advice_usecase = AdviceUsecase(db_session)
    try:
        advice = await advice_usecase.get_advice(user_id["user_id"])
        return advice
    except Exception as e:
        handle_exception(e)
