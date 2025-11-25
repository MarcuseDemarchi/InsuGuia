from typing import Tuple, Dict, Any
from ..infra.database import SessionLocal
from ..infra.database.models.protocolos import Protocolos
from ..infra.database.models.prescricoes import Prescricoes
from ..infra.database.models.paciente import Paciente
import json
import textwrap

class CorePrescricao:
    """
    Gera prescrição (blocos) a partir de um protocolo (procodigo).
    Formato de saída: dict com blocos e texto final.
    """

    def __init__(self):
        pass

    def montar_blocos(self, protocolo: Protocolos, paciente: Paciente) -> Dict[str, Any]:
        """
        Monta blocos de prescrição (B - blocos identificados, indented).
        Retorna dict: { "blocos": {...}, "texto": "..." }
        """

        # Dados base
        dieta = protocolo.prodieta
        escala = float(protocolo.proescaladispositivo) if protocolo.proescaladispositivo else 1
        sensibilidade = protocolo.prosensibilidadeinsu
        glicemia_atual = protocolo.proglicemiaatual
        tipo_basal = protocolo.protipoinsubasal or "NPH"
        posologia_basal = protocolo.proposologiabasal or "A definir"
        bolus_total = protocolo.prolimitebolusprandial or 0

        # Doses (usar proposologiabasal se disponível; caso contrário, calcular simples)
        # Vamos tentar parsear proposologiabasal como número se for simples:
        try:
            basal_calc = float(posologia_basal)
        except Exception:
            # fallback: usar o que estiver em proposologiabasal em texto
            # se o protocolo não tem basais numéricos, usamos a lógica simples:
            dtd = round(paciente.pacpeso * 0.5, 2)
            basal_calc = round(dtd * 0.5, 0)
            if basal_calc % 2 == 1:
                basal_calc += 1

        # bolus prandial: simples regra de divisão (se bolus_total informado)
        if bolus_total and bolus_total > 0:
            # se bolus_total é limite prandial (int), interpretamos como total prandial
            bolus_total_val = int(bolus_total)
            # dividir em 3 refeições se dieta oral, senão 4 se enteral/parenteral
            if dieta in ("oral", "oral_ba", "oral_ma"):
                bolus_por_refeicao = [round(bolus_total_val/3) for _ in range(3)]
            else:
                bolus_por_refeicao = [round(bolus_total_val/4) for _ in range(4)]
        else:
            # fallback simples: derive bolus a partir do dtd
            dtd = round(paciente.pacpeso * 0.5, 2)
            bolus_total_val = round(dtd * 0.5, 2)
            if dieta == "oral":
                bolus_por_refeicao = [
                    round(bolus_total_val * 0.4, 2),
                    round(bolus_total_val * 0.35, 2),
                    round(bolus_total_val * 0.25, 2)
                ]
            else:
                # 4 doses equally
                step = round(bolus_total_val/4, 2)
                bolus_por_refeicao = [step]*4

        # regra de correção simples (exemplo) - pode ser ajustada conforme tabela
        # vamos sugerir: se glicemia > 180 corrigir com Rápida: (glicemia - 100) / 50 => UI
        def correcao_ui(glic):
            if glic <= 100:
                return 0
            return max(0, round((glic - 100) / 50))

        correcao_atual = correcao_ui(glicemia_atual)

        # bloco hipoglicemia
        bloco_hipo = textwrap.dedent("""\
            - Se glicemia capilar < 70 mg/dl:
              * Paciente consciente e capaz de deglutir: oferecer 30 mL glicose 50% (ou alimento açucarado).
              * Se inconsciente: administrar 30 mL glicose 50% IV (em veia calibrosa).
              * Repetir glicemia a cada 15 minutos até >100 mg/dl.
        """)

        # bloco 22h (exemplo padrão do protótipo)
        bloco_22h = textwrap.dedent("""\
            - Orientação 22h:
              * <100 mg/dl: oferecer lanche;
              * 100-250 mg/dl: 0 UI;
              * 251-350 mg/dl: 2 UI Insulina Regular SC;
              * >=351 mg/dl: 4 UI Insulina Regular SC.
        """)

        # montar blocos
        blocos = {
            "Dieta": f"Dieta selecionada: {dieta}",
            "Monitorizacao": "Glicemia capilar conforme protocolo: antes das refeições (AC, AA, AJ) e 22h se dieta oral; 6/6h se NPO ou enteral/parenteral.",
            "Basal": f"Insulina basal sugerida: {tipo_basal} — {basal_calc} U (ajustar por dispositivo; escala: {int(escala)})",
            "Prandial": {
                "descricao": "Doses prandiais sugeridas (por refeição):",
                "valores": bolus_por_refeicao
            },
            "CorrecaoAtual": f"Dose de correção imediata para glicemia {glicemia_atual} mg/dl: {correcao_atual} U de insulina rápida (verificar tabela local).",
            "Hipoglicemia": bloco_hipo,
            "Tabela22h": bloco_22h,
            "Observacoes": "Prescrição orientadora: individualizar conforme equipe assistencial. Projeto acadêmico."
        }

        # gerar texto identado
        texto_blocos = []
        for k, v in blocos.items():
            texto_blocos.append(f"=== {k} ===")
            if isinstance(v, dict):
                texto_blocos.append(v.get("descricao", ""))
                texto_blocos.append("  " + json.dumps(v.get("valores", [])))
            else:
                texto_blocos.append(str(v))
            texto_blocos.append("")  # linha em branco

        texto_final = "\n".join(texto_blocos)

        return {"blocos": blocos, "texto": texto_final}

    def gerar_e_salvar(self, procodigo: int) -> Tuple[bool, str, int, Dict[str, Any]]:
        """
        Gera a prescrição para um protocolo e salva na tabela tbprescricoes.
        Retorna: (ok, mensagem, precodigo, resultado_dict)
        """
        with SessionLocal() as db:
            protocolo = db.query(Protocolos).filter_by(procodigo=procodigo).first()
            if not protocolo:
                return (False, "Protocolo não encontrado", None, {})

            paciente = db.query(Paciente).filter_by(paccodigo=protocolo.paccodigo).first()
            if not paciente:
                return (False, "Paciente do protocolo não encontrado", None, {})

            resultado = self.montar_blocos(protocolo, paciente)
            texto = resultado["texto"]

            # salva na tabela prescricoes
            nova = Prescricoes(
                procodigo=procodigo,
                paccodigo=paciente.paccodigo,
                preconteudo=texto
            )
            db.add(nova)
            db.commit()
            db.refresh(nova)

            return (True, "Prescrição gerada e salva", nova.precodigo, resultado)

    def get_prescricao(self, precodigo: int):
        with SessionLocal() as db:
            rec = db.query(Prescricoes).filter_by(precodigo=precodigo).first()
            if not rec:
                return None
            return {
                "precodigo": rec.precodigo,
                "paccodigo": rec.paccodigo,
                "procodigo": rec.procodigo,
                "preconteudo": rec.preconteudo,
                "predatacriacao": rec.predatacriacao.isoformat() if rec.predatacriacao else None
            }
        
    def get_prescricoes():
        with SessionLocal() as db:
            prescricoes = db.query(Prescricoes).all()

        list_prescricoes = [prescricao.to_dict() for prescricao in prescricoes]

        return list_prescricoes
    

    def get_ultima_prescricao(paccodigo: int):
        with SessionLocal() as db:
            prescricao = db.query(Prescricoes).filter_by(paccodigo=paccodigo).order_by(Prescricoes.procodigo.desc()).first()

        return prescricao.to_dict()