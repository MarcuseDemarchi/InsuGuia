from ..infra.database import SessionLocal
from ..infra.database.models.paciente import Paciente
from ..infra.database.models.protocolos import Protocolos


class CoreProtocolo:
    def __init__(self, peso, idade, sexo, creatinina, 
                 usa_corticoide, dieta_tipo=None,
                 escala_dispositivo=1):
        
        self.peso = peso
        self.idade = idade
        self.sexo = sexo.lower()
        self.creatinina = creatinina
        self.usa_corticoide = usa_corticoide  
        self.dieta_tipo = dieta_tipo
        self.escala_dispositivo = escala_dispositivo

    # ---------- MÉTODOS DE CÁLCULO ----------
    def calcular_tfg(self):
        """ Método Cockcroft-Gault """
        if self.sexo == "feminino":
            fator = 0.85
        else:
            fator = 1

        tfg = ((140 - self.idade) * self.peso) / (72 * self.creatinina)
        return tfg * fator

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

    def classificar_sensibilidade(self):
        if self.usa_corticoide and self.usa_corticoide != "nao":
            return "resistente"
        
        if self.peso < 60:
            return "sensivel"
        elif self.peso <= 90:
            return "usual"
        else:
            return "resistente"

    # =============== AQUI ESTÁ O SEU MÉTODO ==================
    def insert_protocolo(
        self,
        paccodigo: int,
        prodieta: str,
        prousocorticoide: str,
        prodoencahepatica: bool,
        prosensibilidadeinsu: str,
        proglicemiaatual: int,
        escala_dispositivo: int,
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
                proescaladispositivo=escala_dispositivo,
                proposologiabasal=str(doses_calculadas["basal"]),
                prolimitebolusprandial=doses_calculadas["bolus_total"],
                protipocorticosteroide=prousocorticoide,
                protipoinsubasal=None,
                protipoinsulinarapida=None
            )

            db.add(new_protocolo)
            db.commit()
            db.refresh(new_protocolo)

            return (True, "Protocolo cadastrado com sucesso", new_protocolo.procodigo)
