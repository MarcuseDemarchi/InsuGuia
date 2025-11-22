from sqlalchemy import Column, Integer, ForeignKey, DateTime, Text
from sqlalchemy.sql import func
from src.infra.database import Base

class Prescricoes(Base):
    __tablename__ = "tbprescricoes"

    precodigo = Column(Integer, primary_key=True, autoincrement=True)
    procodigo = Column(Integer, ForeignKey("tbprotocolos.procodigo"), nullable=False)
    preconteudo = Column(Text, nullable=True)
    predatacriacao = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )
