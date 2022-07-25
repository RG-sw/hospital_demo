from sqlalchemy.orm import Session

import models, schemas

def get_patient(db: Session, ssn: str):
    return db.query(models.PatientTable).filter(models.PatientTable.ssn == ssn).first()
    