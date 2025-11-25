from sqlalchemy import Column, Integer, String,Boolean, ForeignKey,Float, DateTime
from sqlalchemy.sql import func
from src.infra.database import Base
from src.core.core_paciente import CorePaciente

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
    probolusprandial = Column(Integer, nullable=False)
    prolimitebolusprandial = Column(Integer, nullable=False)
    protipocorticosteroide = Column(String)
    proescaladispositivo = Column(Float, nullable=False)
    prodataemissao = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )

    
    def to_dict(self):
        return {
            "procodigo": self.procodigo,
            "paciente": CorePaciente.get_paciente(self.paccodigo).to_dict(),
            "prodieta": self.prodieta,
            "prousocorticosteroide": self.prousocorticosteroide,
            "prodoencahepatica": self.prodoencahepatica,
            "prosensibilidadeinsu": self.prosensibilidadeinsu,
            "proglicemiaatual": self.proglicemiaatual,
            "protipoinsubasal": self.protipoinsubasal,
            "proposologiabasal": self.proposologiabasal,
            "proinsuacaorapida": self.proinsuacaorapida,
            "probolusprandial": self.probolusprandial,
            "prolimitebolusprandial": self.prolimitebolusprandial,
            "protipocorticosteroide": self.protipocorticosteroide,
            "proescaladispositivo": self.proescaladispositivo,
            "prodataemissao": self.prodataemissao.strftime("%Y-%m-%d %H:%M:%S") if self.prodataemissao else None
        }