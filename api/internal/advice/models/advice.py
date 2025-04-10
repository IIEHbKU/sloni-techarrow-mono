from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

from infra.postgres.client import Base


class AdviceModel(Base):
    __tablename__ = "advice"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"))
    text: Mapped[str] = mapped_column(default="")
    color: Mapped[str] = mapped_column(nullable=False)

    user = relationship(
        "UserModel",
        back_populates="advice"
    )
