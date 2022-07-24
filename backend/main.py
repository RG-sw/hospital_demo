from typing import List, Union

from fastapi import Depends, FastAPI, HTTPException, WebSocket
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from jose import JWTError, jwt
import bcrypt
from pydantic import BaseModel
from datetime import datetime, timedelta

import crud, models, schemas
from database import SessionLocal, engine

from fastapi.middleware.cors import CORSMiddleware  # NEW

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
app = FastAPI()

models.Base.metadata.create_all(bind=engine)

ACCESS_TOKEN_EXPIRE_MINUTES = 30
SECRET_KEY = 'f29960e83d12aa467c08329a283d64463e95f33a61d0eed11a13607062df5d69'
ALGORITHM = "HS256"

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
    user = authenticate_user(fake_users_db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user['username']}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

def authenticate_user(fake_db, username: str, password: str):
    user = get_user(fake_db, username)
    if not user:
        return False
    if not verify_password(password, user['hashed_password']):
        return False
    return user

def get_user(db, username: str):
    if username in db:
        user_dict = db[username]
        return user_dict

def verify_password(plain_password, hashed_password):
    ret = bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password)
    return ret

class Token(BaseModel):
    access_token: str
    token_type: str

def create_access_token(data: dict, expires_delta: Union[timedelta, None] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})  # adds an expire field to the dict
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

fake_users_db = {
    "user": {
        "username": "user",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": b'$2b$12$8XgFKvTt1KyoXNsrPV9fy.OIDTUt4wRbLI.Gs0Y.bpXBWr0KFBVna',
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