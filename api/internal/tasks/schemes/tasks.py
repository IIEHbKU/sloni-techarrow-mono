from typing import List
from datetime import date
from enum import Enum
from pydantic import BaseModel


class TaskCreateRs(BaseModel):
    task_id: int


class TaskCategory(str, Enum):
    LEARNING = "learning"
    WORK = "work"
    PERSONAL = "personal"


class Type(str, Enum):
    UNPLANNED = "unplanned"
    MULTIFACETED = "multifaceted"


class SubTask(BaseModel):
    name: str
    duration: str


class TaskCreateRq(BaseModel):
    type: Type
    name: str
    description: str
    duration: str = None
    importance: bool
    category: TaskCategory
    subtasks: List[SubTask] = None


class TaskToPlanRq(BaseModel):
    date: date
    tasks: List[int]


class TaskToPlanRs(BaseModel):
    status: str


class TaskListDate(BaseModel):
    id: int
    name: str


class TaskListDateRs(BaseModel):
    planned_tasks: List[TaskListDate]
    completed_tasks: List[TaskListDate]


class TaskList(TaskListDate):
    description: str
    duration: str


class TaskListRs(BaseModel):
    tasks: List[TaskList]


class TaskGetRs(BaseModel):
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
