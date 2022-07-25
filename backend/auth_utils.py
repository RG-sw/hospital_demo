from pydantic import BaseModel
import bcrypt
from datetime import datetime
from jose import JWTError, jwt
from datetime import timedelta
from typing import List, Union

ACCESS_TOKEN_EXPIRE_MINUTES = 30
SECRET_KEY = 'f29960e83d12aa467c08329a283d64463e95f33a61d0eed11a13607062df5d69'
ALGORITHM = "HS256"

class Token(BaseModel):
    access_token: str
    token_type: str

def authenticate_user(username: str, password: str):
    user = get_user(fake_users_db, username)
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