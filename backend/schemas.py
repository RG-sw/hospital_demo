from typing import List, Union

from pydantic import BaseModel


class SomeTableBase(BaseModel):
    pass

class SomeTableCreate(SomeTableBase):
    pass

class SomeTable(SomeTableBase):
    id: int
    int_col: int
    str_col: str
    bool_col: bool

    class Config:
        orm_mode = True