from sqlalchemy import Column, Integer, String, ForeignKey
from src.infra.database import Base

class ClassificacoesClinicas(Base):
    """ Tabela de classificacoes clinicas"""
    __tablename__ = "tbclassificacoesclinicas"

    clacodigo = Column(Integer,primary_key=True,index=True,autoincrement=True)
    paccodigo = Column(Integer,ForeignKey("tbpaciente.paccodigo"),nullable=False)
    paccenario = Column(Integer,nullable=False)
    pacdescricao = Column(String(100),nullable=False)