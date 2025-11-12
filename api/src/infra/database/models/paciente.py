from sqlalchemy import Column, Integer, String,Float,ForeignKey,DateTime
from sqlalchemy.sql import func
from src.infra.database import Base

class Paciente(Base):
    """ Tabela de pacientes """
    __tablename__ = "tbpaciente"

    paccodigo = Column(Integer,primary_key=True,index=True,autoincrement=True)
    pacnome = Column(String,nullable=False)
    pacsexo = Column(String,nullable=False)
    pacidade = Column(Integer,nullable=False)
    pacpeso = Column(Float,nullable=False)
    pacaltura = Column(Float,nullable=False)
    pacimc = Column(Float,nullable=False)
    paccreatinina = Column(Float,nullable=False)
    pactfgckdepi = Column(Float,nullable=False)
    paccriado = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False
        )