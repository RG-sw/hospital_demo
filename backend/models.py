from sqlalchemy import Boolean, Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship

from database import Base


class SomeTable(Base):
    __tablename__ = "some_table"

    id = Column(Integer, primary_key=True, index=True)
    int_col = Column(Integer, unique=True, index=True)
    str_col = Column(String, unique=True, index=True)
    bool_col = Column(Boolean, unique=True, index=True)
