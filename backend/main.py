from typing import List, Union

from fastapi import Depends, FastAPI, HTTPException, WebSocket
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

import crud, models, schemas
from database import SessionLocal, engine

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
app = FastAPI()

models.Base.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.websocket("/ws")
async def get_data(websocket: WebSocket):
    await websocket.accept()
    input_text = await websocket.receive_text()
    print(input_text)    
    

@app.get("/sometable/{id}", response_model=schemas.SomeTable)
def read_user(id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    users = crud.get_item(db, id)
    print("inside main", users)
    return users

# @app.get("/")
# def read_root():
#     return {"Hello": "World"}

@app.get("/items/")
async def read_items(token: str = Depends(oauth2_scheme)):
    return {"token": token}

@app.put("/items/{item_id}")
def update_item(item_id: int, item: schemas.SomeTable):
    return {"item": item, "item_id": item_id}


@app.post("/token")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user_dict = fake_users_db.get(form_data.username)
    if not user_dict:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    # user = UserInDB(**user_dict)
    hashed_password = form_data.password  #fake_hash_password(form_data.password)
    if not hashed_password == user_dict['hashed_password']:
        raise HTTPException(status_code=400, detail="Incorrect username or password")

    return {"access_token": user_dict['username'], "token_type": "bearer"}


fake_users_db = {
    "user": {
        "username": "user",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": "web_dev",
        "disabled": False,
    },
    "johndoe": {
        "username": "johndoe",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": "fakehashedsecret",
        "disabled": False,
    },
    "alice": {
        "username": "alice",
        "full_name": "Alice Wonderson",
        "email": "alice@example.com",
        "hashed_password": "fakehashedsecret2",
        "disabled": True,
    },
}