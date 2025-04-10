from datetime import date
from enum import Enum

from sqlalchemy import Date
from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

from infra.postgres.client import Base


class TaskCategory(Enum):
    LEARNING = "learning"
    WORK = "work"
    PERSONAL = "personal"


class CompletedTaskModel(Base):
    __tablename__ = "completed_tasks"

    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"))
    name: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str] = mapped_column(default="")
    category: Mapped[str] = mapped_column(nullable=False)
    duration: Mapped[str] = mapped_column(nullable=False)
    importance: Mapped[bool] = mapped_column(nullable=False)

    date: Mapped[date] = mapped_column(Date, nullable=False)

    is_multi: Mapped[bool] = mapped_column(nullable=False)
    multi_id: Mapped[str] = mapped_column(nullable=True)

    user = relationship(
        "UserModel",
        back_populates="completed_tasks"
    )
