from typing import Dict
from datetime import date

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from infra.keycloak_.access import authenticate
from infra.postgres.access import get_async_session
from internal.tasks.schemes.tasks import TaskCreateRs, TaskCreateRq, TaskToPlanRq, TaskToPlanRs, TaskListDateRs, \
    TaskListRs, TaskGetRs
from internal.tasks.usecase.usecase import TaskUsecase
from pkg.exceptions import handle_exception

router = APIRouter(
    prefix="/api/tasks",
    tags=["Tasks"]
)


@router.post(
    "/create",
    status_code=200,
    response_model=TaskCreateRs
)
async def create_task(
        task: TaskCreateRq,
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskCreateRs:
    task_usecase = TaskUsecase(db_session)
    try:
        task = await task_usecase.create_task(
            user_id["user_id"],
            task
        )
        return task
    except Exception as e:
        handle_exception(e)


@router.put(
    "/to_planned",
    status_code=200,
    response_model=TaskToPlanRs
)
async def to_planned(
        tasks: TaskToPlanRq,
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskToPlanRs:
    task_usecase = TaskUsecase(db_session)
    try:
        task = await task_usecase.to_planned(
            user_id["user_id"],
            tasks
        )
        return task
    except Exception as e:
        handle_exception(e)


@router.get(
    "/get/{data}",
    status_code=200,
    response_model=TaskListDateRs
)
async def get_by_date(
        data: date,
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskListDateRs:
    task_usecase = TaskUsecase(db_session)
    task = await task_usecase.get_by_date(
        user_id["user_id"],
        data
    )
    return task


@router.put(
    "/to_completed/{task_id}",
    status_code=200,
    response_model=TaskToPlanRs
)
async def to_completed(
        task_id: int,
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskToPlanRs:
    task_usecase = TaskUsecase(db_session)
    task = await task_usecase.to_completed(
        user_id["user_id"],
        task_id
    )
    return task


@router.delete(
    "/delete/{task_id}",
    status_code=200,
    response_model=TaskToPlanRs
)
async def delete_task(
        task_id: int,
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskToPlanRs:
    task_usecase = TaskUsecase(db_session)
    task = await task_usecase.delete_task(
        user_id["user_id"],
        task_id
    )
    return task


@router.get(
    "/get_unplanned",
    status_code=200,
    response_model=TaskListRs
)
async def get_unplanned(
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskListRs:
    task_usecase = TaskUsecase(db_session)
    task = await task_usecase.get_unplanned(
        user_id["user_id"]
    )
    return task


@router.get(
    "/get_planned",
    status_code=200,
    response_model=TaskListRs
)
async def get_planned(
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskListRs:
    task_usecase = TaskUsecase(db_session)
    task = await task_usecase.get_planned(
        user_id["user_id"]
    )
    return task


@router.get(
    "/get_completed",
    status_code=200,
    response_model=TaskListRs
)
async def get_completed(
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskListRs:
    task_usecase = TaskUsecase(db_session)
    task = await task_usecase.get_completed(
        user_id["user_id"]
    )
    return task


@router.get(
    "/get_by_id/{task_id}",
    status_code=200,
    response_model=TaskGetRs
)
async def get_by_id(
        task_id: int,
        user_id: Dict[str, str] = Depends(authenticate),
        db_session: AsyncSession = Depends(get_async_session)
) -> TaskGetRs:
    task_usecase = TaskUsecase(db_session)
    task = await task_usecase.get_by_id(
        user_id["user_id"],
        task_id
    )
    return task
