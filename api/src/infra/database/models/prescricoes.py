from sqlalchemy import Column, Integer, ForeignKey, DateTime, Text
from sqlalchemy.sql import func
from src.infra.database import Base
from src.core.core_protocolo import CoreProtocolo

class Prescricoes(Base):
    __tablename__ = "tbprescricoes"

    precodigo = Column(Integer, primary_key=True, autoincrement=True)
    paccodigo = Column(Integer, ForeignKey("tbpaciente.paccodigo"), nullable=False)
    procodigo = Column(Integer, ForeignKey("tbprotocolos.procodigo"), nullable=False)
    preconteudo = Column(Text, nullable=True)
    predatacriacao = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )

    
    def to_dict(self):
        return {
            "precodigo": self.precodigo,
            "paccodigo": self.paccodigo,
            "procodigo": self.procodigo,
            "protocolo": CoreProtocolo.get_protocolo(self.procodigo).to_dict(),
            "preconteudo" : self.preconteudo,
            "datacriacao" : self.predatacriacao.strftime("%Y-%m-%d %H:%M:%S") if self.predatacriacao else None
        }