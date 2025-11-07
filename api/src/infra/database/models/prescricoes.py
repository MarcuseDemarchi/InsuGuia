from sqlalchemy import Column, Integer, String, ForeignKey,DateTime
from sqlalchemy.sql import func
from src.infra.database import Base

class Prescricao(Base):
    """ Tabela de classificacoes prescrições"""
    __tablename__ = "tbprescricao"

    precodigo = Column(Integer,primary_key=True,index=True,autoincrement=True)
    procodigo = Column(Integer,ForeignKey("tbprotocolos.procodigo"),nullable=False)
    prescricaocomple = Column(String,nullable=True)
    predatacriacao = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False)
    preatualizado = Column(
        DateTime(timezone=True),        
        onupdate=func.now(),
        nullable=False)