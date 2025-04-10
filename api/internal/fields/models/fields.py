from datetime import date
from sqlalchemy import Date, Integer, ForeignKey
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import Mapped, mapped_column, relationship

from infra.postgres.client import Base


class FieldModel(Base):
    __tablename__ = "fields"

    date: Mapped[date] = mapped_column(Date, nullable=False, primary_key=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"))
    matrix: Mapped[list[list[int]]] = mapped_column(ARRAY(Integer), nullable=False)

    user = relationship(
        "UserModel",
        back_populates="fields"
    )
