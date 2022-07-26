from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, Date
from sqlalchemy.orm import relationship

from database import Base

class PatientTable(Base):
    __tablename__ = "patient"

    name = Column(String, unique=True, index=True)
    surname = Column(String, unique=True, index=True)
    ssn = Column(String, primary_key=True, index=True)
    birth_date = Column(Date, unique=True, index=True)
    address = Column(String, unique=True, index=True)
    sex = Column(String, unique=True, index=True)
    blood_type = Column(String, unique=True, index=True)
    building = Column(Integer, unique=False, index=True)
