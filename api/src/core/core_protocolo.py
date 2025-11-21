import math

class CoreProtocolo:
    def __init__(self, peso, idade, sexo, creatinina, usa_corticoide,
                 sensibilidade_manual=None, dieta_tipo=None,
                 escala_dispositivo=1):
        
        self.peso = peso
        self.idade = idade
        self.sexo = sexo.lower()
        self.creatinina = creatinina
        self.usa_corticoide = usa_corticoide
        self.sensibilidade_manual = sensibilidade_manual
        self.dieta_tipo = dieta_tipo
        self.escala_dispositivo = escala_dispositivo

    def calcular_tfg(self):
        if self.sexo == "masculino":
            k = 0.9
            a = -0.302
            fator_sexo = 1
        else:
            k = 0.7
            a = -0.241
            fator_sexo = 1.012

        scr_k = self.creatinina / k
        return round(
            142 *
            (min(scr_k, 1)**a) *
            (max(scr_k, 1)**-1.200) *
            (0.9938 ** self.idade) *
            fator_sexo,
            2
        )
    
    def calcular_dtd(self):
        sensib = self.classificar_sensibilidade()

        fatores = {
            "sensivel": 0.2,
            "sensível": 0.2,
            "usual": 0.4,
            "resistente": 0.6
        }

        fator = fatores.get(sensib, 0.4)
        return self.peso * fator

    def arredonda(self, valor):
        if self.escala_dispositivo == 2:
            return int(2 * round(valor / 2))
        return round(valor)
    
    def calcular_doses(self):
        dtd = self.calcular_dtd()
        basal = dtd * 0.5
        bolus_total = dtd * 0.5

        if self.dieta_tipo == "npo":
            bolus_total = 0

        basal = self.arredonda(basal)

        doses_bolus = []
        if bolus_total > 0:
            if self.dieta_tipo == "oral":
                dose_unitaria = self.arredonda(bolus_total / 3)
                doses_bolus = [dose_unitaria] * 3
            else:
                dose_unitaria = self.arredonda(bolus_total / 4)
                doses_bolus = [dose_unitaria] * 4

        return {
            "DTD_total": round(dtd, 2),
            "basal": basal,
            "bolus_total": self.arredonda(bolus_total),
            "bolus_detalhe": doses_bolus
        }
