from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# HOST = '10.105.47.121'
# HOST = '10.106.153.239'
DB_USER = 'postgres' 
DB_PASSWORD = 'postgres'
HOST = '127.0.0.1'
PORT = 5432

SQLALCHEMY_DATABASE_URL = f"postgresql://{DB_USER}:{DB_PASSWORD}@{HOST}:{PORT}/postgres"
# SQLALCHEMY_DATABASE_URL = "postgresql://user:postgres@pg_address:pg_port/db_name"


engine = create_engine(
    SQLALCHEMY_DATABASE_URL
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()
