from flask import Flask,request,jsonify
from src.core.core_user import CoreUser
from src.infra.database import Base,engine
from src.core.core_paciente import CorePaciente
from src.core.core_protocolo import CoreProtocolo
from src.core.core_prescricao import CorePrescricao
from src.infra.database import SessionLocal
from src.infra.database.models.protocolos import Protocolos
from src.infra.database.models.prescricoes import Prescricoes


Base.metadata.create_all(bind=engine)

app = Flask(__name__)
app.config["JSON_AS_ASCII"] = True

@app.get("/")
def index():
    """ Function index do projeto """
    return "Api esta funcionando corretamente"

@app.get("/getAcompanhamentoUltimo")
def get_acompanhamento_ultimo():
    paccodigo = request.args.get("paccodigo", type=int)

    if not paccodigo:
        return jsonify({"message": "Informe o código do paciente (paccodigo)"}), 400

    from src.core.core_acompanhamento import CoreAcompanhamento
    ultimo = CoreAcompanhamento.buscar_ultimo_acompanhamento(paccodigo)

    if not ultimo:
        return jsonify({
            "message": "Nenhum registro de glicemia encontrado para este paciente.",
            "acompanhamento": None
        }), 404

    retorno = {
        "acocodigo": ultimo.acocodigo,
        "paccodigo": ultimo.paccodigo,
        "data_monitoramento": ultimo.acodatamonitoramento,
        "glicemia_jejum": ultimo.acoglicemiajejum,
        "glicemia_pre_almoco": ultimo.acoglicemiaprealmoco,
        "glicemia_pre_jantar": ultimo.acoglicemiaprejantar,
        "glicemia_22h": ultimo.acoglicemia22,
        "ajustes": ultimo.acoajustes
    }

    return jsonify({"message": "Último acompanhamento encontrado", "acompanhamento": retorno}), 200

@app.post("/cadAcompanhamento")
def cadastrar_acompanhamento():
    data = request.json

    if not data:
        return jsonify({"message": "Dados não enviados!"}), 400

    paccodigo = data.get("paciente_codigo")
    if not paccodigo:
        return jsonify({"message": "Código do paciente é obrigatório!"}), 400

    jejum = data.get("glicemia_jejum")
    prealmoco = data.get("glicemia_pre_almoco")
    prejantar = data.get("glicemia_pre_jantar")
    glic22 = data.get("glicemia_22h")
    ajustes = data.get("ajustes")

    from src.core.core_acompanhamento import CoreAcompanhamento
    ok, msg, acocodigo = CoreAcompanhamento.inserir_acompanhamento(
        paccodigo=paccodigo,
        jejum=jejum,
        pre_almoco=prealmoco,
        pre_jantar=prejantar,
        glicemia_22h=glic22,
        ajustes=ajustes
    )

    return jsonify({"message": msg, "acocodigo": acocodigo})

@app.post("/gerarPrescricao")
def gerar_prescricao():
    data = request.json
    if not data:
        return jsonify({
        "code": 404,"message": "procodigo precisa ser informado"}),  404
    procodigo = data.get("procodigo")
    if not procodigo:
        return jsonify({
        "code": 404,"message": "procodigo é obrigatório"}),  404

    corep = CorePrescricao()
    ok, msg, precodigo, resultado = corep.gerar_e_salvar(procodigo)
    if not ok:
        return jsonify({
        "code": 404,"message": msg}), 404

    return jsonify({
        "code": 201,
        "message": msg,
        "precodigo": precodigo,
        "resultado": resultado
    }), 201

@app.get("/getPrescricao")
def get_prescricao():
    precodigo = request.args.get("precodigo", type=int)
    if not precodigo:
        return jsonify({"message": "precodigo é obrigatório"}), 400

    corep = CorePrescricao()
    rec = corep.get_prescricao(precodigo)
    if not rec:
        return jsonify({"message": "Prescrição não encontrada"}), 404

    return jsonify({
        "message": "Prescrição recuperada",
        "prescricao": rec
    }), 200

@app.get("/getPacientes")
def get_todos_pacientes():
    """ Retorna todos os pacientes presentes no banco de dados """
    list_pacientes = CorePaciente.get_pacientes() 
    return list_pacientes


@app.get("/getProtocolo")
def get_protocolos():
    """Retorna os dados completos de todos os protocolos ."""
    return CoreProtocolo.get_protocolos()


@app.get("/getProtocolo/<procodigo>")
def get_protocolo_paciente(procodigo):
    """Retorna os dados completos de um protocolo pelo código (procodigo)."""
    if not procodigo:
        return jsonify({"code": 404, "message": "O código do protocolo (procodigo) deve ser informado"})

    with SessionLocal() as db:
        protocolo = db.query(Protocolos).filter_by(procodigo=procodigo).first()

        if not protocolo:
            return jsonify({"code": 404, "message": "Protocolo não encontrado"})

        protocolo_dict = {
            "procodigo": protocolo.procodigo,
            "paccodigo": protocolo.paccodigo,
            "prodieta": protocolo.prodieta,
            "prousocorticosteroide": protocolo.prousocorticosteroide,
            "protipocorticosteroide": protocolo.protipocorticosteroide,
            "prodoencahepatica": protocolo.prodoencahepatica,
            "prosensibilidadeinsu": protocolo.prosensibilidadeinsu,
            "protipoinsubasal": protocolo.protipoinsubasal,
            "proescaladispositivo": float(protocolo.proescaladispositivo) if protocolo.proescaladispositivo else None,
            "proposologiabasal": protocolo.proposologiabasal,
            "protipoinsulinarapida": protocolo.proinsuacaorapida,
            "probolusprandiintal": protocolo.probolusprandial,
            "proglicemiaatual": protocolo.proglicemiaatual,
            "prodataemissao" : protocolo.prodataemissao,
        }

    return jsonify({
        "code" : 201,
        "message": "Dados do protocolo recuperados com sucesso",
        "protocolo": protocolo_dict
    })

@app.post("/cadProtocolo")
def cadastrar_protocolo_paciente():
    data = request.json

    if not data:
        return jsonify({"code": 404, "message": "Dados não informados"})
    
    paccodigo = data.get("paciente_codigo")
    if not paccodigo:
        return jsonify({"code": 404, "message": "Código do paciente é obrigatório"})

    prodieta = data.get("protocolo_dieta")
    prousocorticoide = data.get("protocolo_corticosteroide")
    prodoencahepatica = bool(data.get("protocolo_doenca_hepatica", False))
    prosensibilidadeinsu = data.get("protocolo_sensibilidade_insulina")
    proglicemiaatual = int(data.get("protocolo_glicemia_atual"))    
    proescaladispositivo = data.get("protocolo_escala_dispositivo")
    protipoinsubasal = data.get("protocolo_tipo_insulina_basal")
    proposologiabasal = data.get("protocolo_posologia_basal")
    proinsuacaorapida = data.get("protocolo_insulina_rapida")
    probolusprandial = data.get("protocolo_bolus_prandial")
    usa_corticoide_bool = (prousocorticoide.lower() != "nao")

    data_paciente = CorePaciente.get_paciente(paccodigo=paccodigo)
    if not data_paciente:
        return jsonify({"code": 404, "message": "Paciente não encontrado!"}),

    core = CoreProtocolo(
        peso=data_paciente.pacpeso,
        idade=data_paciente.pacidade,
        sexo=data_paciente.pacsexo,
        creatinina=data_paciente.paccreatinina,
        usa_corticoide=usa_corticoide_bool,
        dieta_tipo=prodieta,
        proescaladispositivo=proescaladispositivo
    )
    
    doses = core.calcular_doses()

    ok, msg, procodigo = core.insert_protocolo(
        paccodigo=paccodigo,
        prodieta=prodieta,
        prousocorticoide=usa_corticoide_bool,
        prodoencahepatica=prodoencahepatica,
        prosensibilidadeinsu=prosensibilidadeinsu,
        proglicemiaatual=proglicemiaatual,
        proescaladispositivo=proescaladispositivo,
        protipoinsubasal=protipoinsubasal,
        proposologiabasal=proposologiabasal,
        protipocorticosteroide=prousocorticoide,
        proinsuacaorapida=proinsuacaorapida,
        probolusprandial=probolusprandial,
        doses_calculadas=doses
    )

    if not ok:
        return jsonify({"code": 500, "message": msg})

    return jsonify({
        "code": 201,
        "message": msg,
        "procodigo": procodigo,
        "resultado": {
            "TFG": float(data_paciente.pactfgckdepi),
            "sensibilidade": prosensibilidadeinsu,
        "doses": {
            "DTD_total": float(doses["DTD_total"]),
            "basal": float(doses["basal"]),
            "bolus_total": float(doses["bolus_total"]),
            "bolus_detalhe": doses["bolus_detalhe"]
        }
    }})

@app.post("/cadPaciente")
def cadastrar_paciente():
    """ Cadastra novos pacientes """
    data_paciente = request.json

    if not data_paciente:
        return jsonify({
            "code" : 400,
            "message" : "Atenção: dados não informados!"}),
    
    pacname = data_paciente.get("paciente_nome")
    pacsexo = data_paciente.get("paciente_sexo")
    pacidade = data_paciente.get("paciente_idade")
    pacpeso = data_paciente.get("paciente_peso")
    pacaltura = data_paciente.get("paciente_altura")
    paccreatinina = data_paciente.get("paciente_creatinina")
    pacimc = data_paciente.get("paciente_imc")
    pactfg = data_paciente.get("paciente_tfg")
    paclocalinternacao = data_paciente.get("paciente_localinternacao")

    pac_obj = CorePaciente(pacname,pacsexo,
                    pacidade, pacpeso,
                    pacaltura,paccreatinina,
                    pacimc,pactfg, paclocalinternacao)
    
    data_paciente_valido,txt_retorno = pac_obj.valid_campos()

    if not data_paciente_valido:
        return jsonify({
            "code" : 400,
            "message" : f"{txt_retorno}"})
    
    try:
        pac_obj.insert_paciente()
        return jsonify({
            "code" : 201,
            "message" : "Paciente inserido com sucesso!"})
    except Exception as e:
        print(f"Erro ao inserir paciente: {e}")
        return jsonify({
            "code" : 500,
            "message" : f"Erro interno ao inserir paciente: {e}"})
    
@app.delete('/deletePaciente/<paccodigo>')
def deletar_paciente(paccodigo):
    """Deletar um paciente Específico"""
    if not paccodigo:
        return jsonify({
            "code" : 404,
            "message" : "Atenção: dados não informados!"
        }),

    try:
        deleted, msg = CorePaciente.delete_paciente(paccodigo)

        if deleted:
            print(msg)
            return jsonify({
                "code" : 204,
                "message" : msg
            })
        else:
            print(msg)
            return jsonify({
                "code" : 404,
                "message" : msg
            })
    except Exception as e:
        print(f"Erro ao deletar paciente: {e}")
        return jsonify({
            "code" : 500,
            "message" : f"Erro interno ao deletar paciente: {e}"})
 
@app.put('/updatePaciente/<paccodigo>')
def atualizar_paciente(paccodigo):
    """Atualiza um paciente Específico"""
    data_paciente = request.json
    
    if not paccodigo or not data_paciente:
        return jsonify({
            "code" : 404,
            "message" : "Atenção: dados não informados!"
        }),


    pacname = data_paciente.get("paciente_nome")
    pacsexo = data_paciente.get("paciente_sexo")
    pacidade = data_paciente.get("paciente_idade")
    pacpeso = data_paciente.get("paciente_peso")
    pacaltura = data_paciente.get("paciente_altura")
    paccreatinina = data_paciente.get("paciente_creatinina")
    pacimc = data_paciente.get("paciente_imc")
    pactfg = data_paciente.get("paciente_tfg")
    paclocalinternacao = data_paciente.get("paciente_localinternacao")

    try:
        updated, msg = CorePaciente.update_paciente(paccodigo=paccodigo,
                                                    pacnome=pacname,
                                                    pacsexo=pacsexo,
                                                    pacidade=pacidade,
                                                    pacpeso=pacpeso,
                                                    pacaltura=pacaltura,
                                                    paccreatinina=paccreatinina,
                                                    pacimc=pacimc,
                                                    pactfgckdepi=pactfg,
                                                    paclocalinternacao=paclocalinternacao)

        if updated:
            return jsonify({
                "code" : 204,
                "message" : msg
            })
        else:
            return jsonify({
                "code" : 404,
                "message" : msg
            })
    except Exception as e:
        print(f"Erro ao atualizar paciente: {e}")
        return jsonify({
            "code" : 500,
            "message" : f"Erro interno ao atualizar paciente: {e}"})
       

@app.post("/validUser")
def user_valid():
    """ Valida o acesso do usuário """
    fc_user = CoreUser()
    data_user = request.json

    if not data_user:
        return jsonify({
            "code" : 500,
            "message" : "Dados não informados"})
    
    usrmail = data_user.get("user_email")
    password = data_user.get("senha_acesso")

    valid_user = fc_user.valid_user(usrmail,password)
    if not valid_user[0]:
        return jsonify({
            "code" : 500,
            "message" : valid_user[1]})

    return jsonify({
        "code" : 200,
        "message" : f"{valid_user[1]}"})

@app.post("/cadUser")
def user_register():
    """ Cadastra o usuário dentro do sistema """
    fc_user = CoreUser()
    data_user = request.json

    if not data_user:
        return jsonify({"message" : "Dados nao informados"})
    
    user_name_full = data_user.get("user_name_full")
    password = data_user.get("password")
    user_email  = data_user.get("user_email")

    usrname_valid = fc_user.create_username_valid(user_name_full)
    pass_valid = fc_user.create_password_valid(password)
    mail_valid = fc_user.create_email_valid(user_email)

    if not usrname_valid[0]:
        return jsonify({
            "code" : 500,
            "message" : usrname_valid[1]})
    if not mail_valid[0]:
        return jsonify({
            "code" : 500,
            "message" : mail_valid[1]})
    if not pass_valid[0]:
        return jsonify({
            "code" : 500,
            "message" : pass_valid[1]})

    try:
        fc_user.create_user(
            usrnamefull=user_name_full,
            password=password,
            user_email=user_email
        )
        return jsonify({
            "code" : 201,
            "message": f"Usuario cadastrado com sucesso!"
        })
    except ValueError as e:
        return jsonify ({
            "code" : 500,
            "message" : f"Ocorreu um erro ao tentar registrar usuario"
        })

if __name__ == "__main__":
    app.run('127.0.0.1',5000)