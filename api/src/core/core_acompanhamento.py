from ..infra.database import SessionLocal
from ..infra.database.models.acompanhamentos import Acompanhamento

class CoreAcompanhamento:

    @staticmethod
    def sugerirAjustes(acompanhamento : Acompanhamento):
        msgs = ''
        if(acompanhamento.acoglicemiajejum > 180 and acompanhamento.acoglicemiaprealmoco > 180 and acompanhamento.acoglicemiaprejantar>180): 
            msgs += '- Elevar basal em ~10% e reavaliar em 24h.\n'

        if(acompanhamento.acoglicemiajejum < 90):
            msgs += '- Reduzir basal em ~10% para evitar hipoglicemias em jejum.\n'

        if(acompanhamento.acoglicemiaprealmoco > 180 or acompanhamento.acoglicemiaprejantar>180):
            msgs += '- Considerar +1–2 UI na prandial das refeições elevadas.\n'

        if(acompanhamento.acoglicemia22 > 200):
            msgs += '- Aplicar correção às 22h conforme tabela desta prescrição.\n'
            
        if(len(msgs) ==0):
            msgs += 'Manter esquema atual e monitorizar.'
            
        return msgs


    @staticmethod
    def inserir_acompanhamento(paccodigo: int,
                               jejum: int = 0,
                               pre_almoco: int = 0,
                               pre_jantar: int = 0,
                               glicemia_22h: int = 0):

        with SessionLocal() as db:
            novo = Acompanhamento(
                paccodigo=paccodigo,
                acoglicemiajejum=jejum,
                acoglicemiaprealmoco=pre_almoco,
                acoglicemiaprejantar=pre_jantar,
                acoglicemia22=glicemia_22h,
            )

            novo.acoajustes = CoreAcompanhamento.sugerirAjustes(novo)

            db.add(novo)
            db.commit()
            db.refresh(novo)

            return True, "Acompanhamento registrado com sucesso", novo.acoajustes

    @staticmethod
    def buscar_ultimo_acompanhamento(paccodigo: int):
        with SessionLocal() as db:

            ultimo = (
                db.query(Acompanhamento)
                .filter_by(paccodigo=paccodigo)
                .order_by(Acompanhamento.acodatamonitoramento.desc())
                .first()
            )

            return ultimo
