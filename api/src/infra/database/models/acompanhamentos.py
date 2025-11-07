from sqlalchemy import Column, Integer, String, ForeignKey,DateTime
from sqlalchemy.sql import func
from src.infra.database import Base

class Acompanhamento(Base):
    """ Tabela de acompanhamento"""
    __tablename__ = "tbacompanhamento"

    acocodigo = Column(Integer,primary_key=True,index=True,autoincrement=True)
    paccodigo = Column(Integer,ForeignKey("tbpaciente.paccodigo"),nullable=False)
    acodatamonitoramento = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False)
    acoglicemiajejum = Column(Integer)
    acoglicemiaprealmoco = Column(Integer)
    acoglicemiaprejantar = Column(Integer)
    acoglicemia22 = Column(Integer)
    acoajustes = Column(String(255))    
    acodatacriacao = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False)
    acoatualizado = Column(
        DateTime(timezone=True),        
        onupdate=func.now(),
        nullable=False)