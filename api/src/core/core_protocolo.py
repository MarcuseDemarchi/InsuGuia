from ..infra.database import SessionLocal
from ..infra.database.models.paciente import Paciente
from ..infra.database.models.protocolos import Protocolos

class CoreProtocolo:
    def __init__(self, peso, idade, sexo, creatinina, 
                 usa_corticoide, dieta_tipo=None,
                 proescaladispositivo=1):
        
        self.peso = peso
        self.idade = idade
        self.sexo = sexo.lower()
        self.creatinina = creatinina
        self.usa_corticoide = usa_corticoide  
        self.dieta_tipo = dieta_tipo
        self.proescaladispositivo = proescaladispositivo

    def get_protocolos():
        """ Get em todos os protocolos do banco """
        with SessionLocal() as db:
            protocolos = db.query(Protocolos).all()            
        
        list_protocolos = [protocolo.to_dict() for protocolo in protocolos]

        return list_protocolos

    def calcular_doses(self):
        """ Regra simplificada para teste do sistema """

        DTD_total = round(self.peso * 0.5, 2)
        basal = round(DTD_total * 0.5, 2)
        bolus_total = round(DTD_total * 0.5, 2)

        bolus_detalhe = {
            "cafe": round(bolus_total * 0.4, 2),
            "almoco": round(bolus_total * 0.35, 2),
            "jantar": round(bolus_total * 0.25, 2),
        }

        return {
            "DTD_total": DTD_total,
            "basal": basal,
            "bolus_total": bolus_total,
            "bolus_detalhe": bolus_detalhe
        }

    def insert_protocolo(
        self,
        paccodigo: int,
        prodieta: str,
        prousocorticoide: bool,
        prodoencahepatica: bool,
        prosensibilidadeinsu: str,
        proglicemiaatual: int,
        proescaladispositivo: float,
        protipoinsubasal : str,
        proposologiabasal : str,
        protipocorticosteroide : str,
        proinsuacaorapida : str,
        probolusprandial : int,
        doses_calculadas: dict
    ):
        with SessionLocal() as db:
            
            paciente = db.query(Paciente).filter_by(paccodigo=paccodigo).first()
            if not paciente:
                return (False, "Paciente não encontrado", None)

            new_protocolo = Protocolos(
                paccodigo=paccodigo,
                prodieta=prodieta,
                prousocorticosteroide=prousocorticoide,
                prodoencahepatica=prodoencahepatica,
                prosensibilidadeinsu=prosensibilidadeinsu,
                proglicemiaatual=proglicemiaatual,
                proescaladispositivo=proescaladispositivo,
                proposologiabasal=proposologiabasal,
                probolusprandial=probolusprandial,
                prolimitebolusprandial=doses_calculadas["bolus_total"],
                protipocorticosteroide=protipocorticosteroide,
                protipoinsubasal=protipoinsubasal,
                proinsuacaorapida=proinsuacaorapida
            )

            db.add(new_protocolo)
            db.commit()
            db.refresh(new_protocolo)

            return (True, "Protocolo cadastrado com sucesso", new_protocolo.procodigo)