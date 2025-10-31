from sqlalchemy import Column, Integer, String
from src.infra.database import Base

class User(Base):
    """ Tabela de usuário"""
    __tablename__ = "tbuser"

    usrcodigo = Column(Integer,primary_key=True,index=True,autoincrement=True)
    usrname = Column(String(length=15),nullable=False)
    usrpassword = Column(String(length=255),nullable=False)
    usremail = Column(String(length=45),nullable=False,unique=True)
    usrsalt = Column(String,nullable=False,unique=True)