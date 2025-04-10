from typing import List

from pydantic import BaseModel


class AdviceCreateRs(BaseModel):
    id: int
    text: str
    color: str


class AdviceGetRs(BaseModel):
    advice: List[AdviceCreateRs]


class AdviceCreateRq(BaseModel):
    ids: List[int]
