from ..infra.database import SessionLocal
from ..infra.database.models.acompanhamentos import Acompanhamento

class CoreAcompanhamento:

    @staticmethod
    def inserir_acompanhamento(paccodigo: int,
                               jejum: int = None,
                               pre_almoco: int = None,
                               pre_jantar: int = None,
                               glicemia_22h: int = None,
                               ajustes: str = None):

        with SessionLocal() as db:
            novo = Acompanhamento(
                paccodigo=paccodigo,
                acoglicemiajejum=jejum,
                acoglicemiaprealmoco=pre_almoco,
                acoglicemiaprejantar=pre_jantar,
                acoglicemia22=glicemia_22h,
                acoajustes=ajustes
            )

            db.add(novo)
            db.commit()
            db.refresh(novo)

            return True, "Acompanhamento registrado com sucesso", novo.acocodigo

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
