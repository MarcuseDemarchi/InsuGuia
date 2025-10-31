from sqlalchemy import column, Integer, String
from src.infra.database import Base



class Paciente(Base):
    """ Tabela de pacientes """
    __tablename__ = "tbpaciente"