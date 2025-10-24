from sqlalchemy import Column, Integer, String
from src.infra.database import Base

class user(Base):
    __tablename__ = "tbuser"

    usrcodigo = Column(Integer,primary_key=True,index=True,autoincrement=True)
    usrname = Column(String(length=15),nullable=False)
    usrpassword = Column(String(length=45),nullable=False)
    usremail = Column(String(length=45),nullable=False)