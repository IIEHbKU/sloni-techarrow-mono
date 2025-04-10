from typing import Dict
from datetime import date

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from infra.keycloak_.access import authenticate
from infra.postgres.access import get_async_session
from internal.fields.schemes.fields import FieldInput, FieldAnswer, FieldOutput
from internal.fields.usecase.usecase import FieldUsecase
from pkg.exceptions import handle_exception

router = APIRouter(
    prefix="/api/fields",
    tags=["Fields"]
)


@router.put(
    "/update",
    status_code=200,
    response_model=FieldAnswer,
)
async def update_field(
        field: FieldInput,
        user_id: Dict[str, str] = Depends(authenticate),
        session: AsyncSession = Depends(get_async_session)
) -> FieldAnswer:
    try:
        field_usecase = FieldUsecase(session)
        f = await field_usecase.update_field(user_id["user_id"], field)
        return f
    except Exception as e:
        raise handle_exception(e)


@router.get(
    "/get/{date}",
    status_code=200,
    response_model=FieldOutput,
)
async def get_field(
        date: date,
        user_id: Dict[str, str] = Depends(authenticate),
        session: AsyncSession = Depends(get_async_session)
) -> FieldOutput:
    try:
        field_usecase = FieldUsecase(session)
        f = await field_usecase.get_field(user_id["user_id"], date)
        return f
    except Exception as e:
        raise handle_exception(e)
