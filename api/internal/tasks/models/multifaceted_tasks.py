from enum import Enum

from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

from infra.postgres.client import Base


class TaskCategory(Enum):
    LEARNING = "learning"
    WORK = "work"
    PERSONAL = "personal"


class MultifacetedTaskModel(Base):
    __tablename__ = "multifaceted_tasks"

    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"))
    name: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str] = mapped_column(default="")
    category: Mapped[str] = mapped_column(nullable=False)
    importance: Mapped[bool] = mapped_column(nullable=False)
    color: Mapped[str] = mapped_column(nullable=False)

    user = relationship(
        "UserModel",
        back_populates="multifaceted_tasks"
    )
