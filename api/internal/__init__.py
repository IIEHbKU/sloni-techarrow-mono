from fastapi import FastAPI

# from internal.advice.api.v1.routers import router as advice_router
from internal.fields.api.v1.routers import router as field_router
from internal.healthcheck.api.v1.routers import router as healthcheck_router
from internal.superadmin.api.v1.routers import router as superadmin_router
from internal.tasks.api.v1.routers import router as task_router
from internal.users.api.v1.routers import router as user_router


def init_routers(
        app: FastAPI
) -> None:
    # app.include_router(advice_router)
    app.include_router(field_router)
    app.include_router(healthcheck_router)
    app.include_router(superadmin_router)
    app.include_router(task_router)
    app.include_router(user_router)
