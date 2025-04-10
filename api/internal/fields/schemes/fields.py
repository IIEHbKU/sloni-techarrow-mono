from datetime import date
from enum import Enum
from typing import List

from pydantic import BaseModel


class FieldInput(BaseModel):
    date: date
    list: List[List[int]]


class FieldAnswer(BaseModel):
    status: str


class TaskCategory(str, Enum):
    LEARNING = "learning"
    WORK = "work"
    PERSONAL = "personal"


class TaskInfo(BaseModel):
    id: int
    name: str
    description: str
    category: TaskCategory
    duration: str
    importance: bool
    is_multi: bool
    multi_id: str | None
    multi_color: str | None
    multi_name: str | None
    multi_description: str | None


class FieldOutput(BaseModel):
    date: date
    matrix: List[List[int]]
    info: List[TaskInfo]
