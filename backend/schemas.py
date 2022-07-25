from codecs import charmap_build
from datetime import date, datetime
from typing import List, Union

from pydantic import BaseModel


class PatientBase(BaseModel):
    pass

class Patient(PatientBase):
    name: str
    surname: str
    ssn: str
    birth_date: date
    address: str
    sex: str
    blood_type: str
    building: int

    class Config:
        orm_mode = True