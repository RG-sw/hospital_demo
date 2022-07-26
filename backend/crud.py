# from datetime import datetime, date
# from unicodedata import name
# from requests import delete
from sqlalchemy.orm import Session

import models, schemas

def read_patient(db: Session, ssn: str):
    return db.query(models.PatientTable).filter(models.PatientTable.ssn == ssn).first()

def create_patient(db: Session, ssn: str):
    db_item = models.PatientTable(
        name='',
        surname='',
        ssn=ssn,
        birth_date='10-10-2002',
        address='',
        sex='',
        blood_type='',
        building=0)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item

def delete_patient(db: Session, ssn: str):
    db_patient = read_patient(db, ssn)
    if not db_patient:
        return False
    else:
        db.delete(db_patient)
        db.commit()
        return 'deleted'

def update_patient_address(db: Session, ssn: str, address: str):
    db_patient = read_patient(db, ssn)
    if not db_patient:
        return False
    else:
        db_patient.address = address
        db.add(db_patient)
        db.commit()
        db.refresh(db_patient)
        return 'updated'
    