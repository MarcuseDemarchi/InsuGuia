import os
from dotenv import load_dotenv

load_dotenv()
class SettingsPostgres():
    """ Classe responsável por carregar as configurações do banco de dados postgresql """
    
    DATABASE_IP = os.getenv("DATABASE_IP")
    DATABASE_PORT = os.getenv("DATABASE_PORT")
    DATABASE_NAME = os.getenv("DATABASE_NAME")
    DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD")
    DATABASE_USER = os.getenv("DATABASE_USER")
    DATABASE_URL = f"postgresql+psycopg2://{DATABASE_USER}:{DATABASE_PASSWORD}@{DATABASE_IP}:{DATABASE_PORT}/{DATABASE_NAME}"