from sqlalchemy import Column, Integer, String,Boolean, ForeignKey,DECIMAL
from src.infra.database import Base

class Protocolos(Base):
    """ Tabela de protocolos médicos"""
    __tablename__ = "tbprotocolos"

    procodigo = Column(Integer, primary_key=True, autoincrement=True)
    paccodigo = Column(Integer, ForeignKey("tbpaciente.paccodigo"), nullable=False)    
    prodieta = Column(String(20), nullable=False) 
    prousocorticosteroide = Column(String(20), nullable=False)
    prodoencahepatica = Column(Boolean, default=False, nullable=False)
    prosensibilidadeinsu = Column(String(20), nullable=False)
    proglicemiaatual = Column(Integer, nullable=False)    
    protipoinsubasal = Column(String(255))
    proposologiabasal = Column(String(100), nullable=False)
    proinsuacaorapida = Column(String(255), nullable=False)
    prolimitebolusprandial = Column(Integer, nullable=False)
    protipocorticosteroide = Column(String)
    proescaladispositivo = Column(DECIMAL(4,2), nullable=False)