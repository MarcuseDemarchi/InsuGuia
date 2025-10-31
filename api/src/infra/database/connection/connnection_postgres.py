from src.settings.settings_database import SettingsPostgres
from src.infra.database import SessionLocal
from sqlalchemy import text
from sqlalchemy.orm import Session

class ConnectionPostgres():
    """ Classe de conexão com postgres, aqui vai ter tudo de consulta"""
    def __init__(self):
        self.URL_CONN = SettingsPostgres.DATABASE_URL
    
    def select_all(self, query_def : str):
        with SessionLocal() as db:
            pass