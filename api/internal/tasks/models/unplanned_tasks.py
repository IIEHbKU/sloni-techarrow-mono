from datetime import date

from sqlalchemy import Date
from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

from infra.postgres.client import Base


class UnplannedTaskModel(Base):
    __tablename__ = "unplanned_tasks"

    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"))
    name: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str] = mapped_column(default="")
    category: Mapped[str] = mapped_column(nullable=False)
    duration: Mapped[str] = mapped_column(nullable=False)
    importance: Mapped[bool] = mapped_column(nullable=False)

    date: Mapped[date] = mapped_column(Date, nullable=True)

    is_multi: Mapped[bool] = mapped_column(nullable=False)
    multi_id: Mapped[str] = mapped_column(nullable=True)

    user = relationship(
        "UserModel",
        back_populates="unplanned_tasks"
    )
