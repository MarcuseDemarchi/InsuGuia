from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from src.settings.settings_database import SettingsPostgres

engine = create_engine(SettingsPostgres.DATABASE_URL, echo=True)
SessionLocal = sessionmaker(autoflush=False, bind=engine)

Base = declarative_base()