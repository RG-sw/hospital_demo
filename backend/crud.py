from sqlalchemy.orm import Session

import models, schemas

def get_item(db: Session, id: int = 0):
    db_query = db.query(models.SomeTable).filter(models.SomeTable.id == id).first()
    print(db_query)
    return db_query
