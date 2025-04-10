from sqlalchemy.orm import Mapped, mapped_column, relationship

from infra.postgres.client import Base


class UserModel(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(nullable=False)
    email: Mapped[str] = mapped_column(nullable=False)

    fields = relationship(
        "FieldModel",
        back_populates="user",
        cascade="all, delete-orphan"
    )

    multifaceted_tasks = relationship(
        "MultifacetedTaskModel",
        back_populates="user",
        cascade="all, delete-orphan"
    )

    unplanned_tasks = relationship(
        "UnplannedTaskModel",
        back_populates="user",
        cascade="all, delete-orphan"
    )

    completed_tasks = relationship(
        "CompletedTaskModel",
        back_populates="user",
        cascade="all, delete-orphan"
    )

    planned_tasks = relationship(
        "PlannedTaskModel",
        back_populates="user",
        cascade="all, delete-orphan"
    )

    advice = relationship(
        "AdviceModel",
        back_populates="user",
        cascade="all, delete-orphan"
    )
