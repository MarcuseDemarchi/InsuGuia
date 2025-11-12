from ..infra.database import SessionLocal
from ..infra.database.models.paciente import Paciente

class CorePaciente():
    """ Classe responsavel por gerenciar as regras do paciente """
    def __init__():
        pass

    def insert_paciente():
        pass

    def valid_campos(pacnome : str, pacsexo : str, 
                     pacidade : int, pacpeso : float,
                     pacaltura : float,paccreatinina : float,
                     pacimc : float,pactfgckdepi : float) -> tuple[bool,str]:
        pass
        
