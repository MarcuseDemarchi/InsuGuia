from sqlalchemy import Column, Integer, String,Boolean, ForeignKey,DECIMAL
from src.infra.database import Base

class Protocolos(Base):
    """ Tabela de protocolos médicos"""
    __tablename__ = "tbprotocolos"

    procodigo = Column(Integer,primary_key=True,index=True,autoincrement=True)

    paccodigo = Column(Integer,ForeignKey("tbpaciente.paccodigo"),nullable=False)    
    prodieta = Column(String(20),nullable=False)
    prousocorticosteroide = Column(Boolean,nullable=False)
    protipocorticosteroide = Column(String(20),nullable=False)
    prodoencahepatica = Column(Boolean,default=False,nullable=False)
    prosensibilidadeinsu = Column(Boolean,default=False,nullable=False)
    protipoinsubasal = Column(String(20))
    proescaladispositivo = Column(DECIMAL(4,2))
    proposologiabasal = Column(String(50))
    protipoinsulinarapida = Column(String(20))
    prolimitebolusprandial = Column(Integer)
    proclicemiaatual = Column(Integer,nullable=False)

    progestante = Column(Boolean,default=False)
    prosemanasgestantes = Column(Integer)