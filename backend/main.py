from fastapi import Depends, FastAPI, HTTPException, WebSocket
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware

from sqlalchemy.orm import Session

from datetime import timedelta

import crud, models, schemas
from database import SessionLocal, engine
from auth_utils import Token, authenticate_user, create_access_token, ACCESS_TOKEN_EXPIRE_MINUTES




oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
app = FastAPI()

models.Base.metadata.create_all(bind=engine)

# to allow frontend from different hosts, protocols, ecc..
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8080", "http://127.0.0.1:8080", 'http://127.0.0.1:3000'],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

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
    
@app.get("/patient/{ssn}", response_model=schemas.Patient)
def read_patient(ssn: str, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    user = crud.get_patient(db, ssn)
    print("inside main", user)
    return user

# @app.get("/")
# def read_root():
#     return {"Hello": "World"}

@app.post("/token", response_model=Token)
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user['username']}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

