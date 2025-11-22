from ..infra.database import SessionLocal
from ..infra.database.models.paciente import Paciente

class CorePaciente:
    """ Classe responsavel por gerenciar as regras do paciente """
    def __init__(self,pacnome : str, pacsexo : str, 
                    pacidade : int, pacpeso : float,
                    pacaltura : float,paccreatinina : float,
                    pacimc : float,pactfgckdepi : float, 
                    paclocalinternacao : str):
        self.pacnome = pacnome
        self.pacsexo = pacsexo
        self.pacidade = pacidade
        self.pacpeso = pacpeso
        self.pacaltura = pacaltura
        self.paccreatinina = paccreatinina
        self.pacimc = pacimc
        self.pactfgckdepi = pactfgckdepi
        self.paclocalinternacao = paclocalinternacao

    def insert_paciente(self) -> tuple[bool,str]:
        """ Insere paciente no banco de dados! """
        new_paciente = Paciente(
            pacnome=self.pacnome,
            pacsexo=self.pacsexo,
            pacidade=self.pacidade,
            pacpeso=self.pacpeso,
            pacaltura=self.pacaltura,
            pacimc=self.pacimc,
            paccreatinina=self.paccreatinina,
            pactfgckdepi=self.pactfgckdepi,
            paclocalinternacao=self.paclocalinternacao
        )

        with SessionLocal() as db:
            db.add(new_paciente)
            db.commit()
            db.refresh(new_paciente)

        return [True,"Paciente cadastrado com sucesso"]

    def valid_campos(self) -> tuple[bool,str]:
        if not self.pacnome:
            return [False, "Atenção : o campo nome é obrigatorio e não pode ser nulo!"]
        elif not self.pacsexo:
            return [False, "Atenção : o campo sexo é obrigatorio e não pode ser nulo!"]
        elif not self.pacidade or self.pacidade <= 0:
            return [False, "Atenção : o campo idade é obrigatorio e não pode ser nulo ou 0!"]
        elif not self.pacpeso or self.pacpeso <= 0:
            return [False, "Atenção : o campo peso é obrigatorio e não pode ser nulo ou 0!"]
        elif not self.pacaltura or self.pacaltura <= 0:
            return [False, "Atenção : o campo altura é obrigatorio e não pode ser nulo ou 0!"]
        elif not self.paccreatinina or self.paccreatinina <= 0:
            return [False, "Atenção : o campo creatinina é obrigatorio e não pode ser nulo ou 0!"]
        elif not self.pactfgckdepi or self.pactfgckdepi <= 0:
            return [False, "Atenção : o campo TFG é obrigatorio e não pode ser nulo ou 0!"]
        elif not self.pacimc:
            return [False, "Atenção : o campo IMC é obrigatorio e não pode ser nulo!"]
        elif not self.paclocalinternacao:
            return [False, "Atenção : o campo Local de Internação é obrigatorio e não pode ser nulo!"]
        else:
            return [True, "Campos válidos!"]
        
    def get_pacientes():
        """ Get em todos os pacientes do banco """
        with SessionLocal() as db:
            pacientes = db.query(Paciente).all()            
        
        list_pacientes = [paciente.to_dict() for paciente in pacientes]

        return list_pacientes