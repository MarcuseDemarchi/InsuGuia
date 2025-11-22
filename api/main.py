from flask import Flask,request,jsonify
from src.core.core_user import CoreUser
from src.infra.database import Base,engine
from src.core.core_paciente import CorePaciente


Base.metadata.create_all(bind=engine)

app = Flask(__name__)
app.config["JSON_AS_ASCII"] = True

@app.get("/")
def index():
    """ Function index do projeto """
    return "Api esta funcionando corretamente"

@app.get("/getPacientes")
def get_todos_pacientes():
    """ Retorna todos os pacientes presentes no banco de dados """
    list_pacientes = CorePaciente.get_pacientes() 
    return list_pacientes

@app.post("/cadProtocolo")
def cadastrar_protocolo_paciente():
    """ Cadastra um protocolo para o paciente """
    data_protocolo_paciente = request.json

    if not data_protocolo_paciente:
        return jsonify({"message" : "Atenção : Os dados de cadastro do protocolo do paciente não foi informado"}),400
    
    prodieta = data_protocolo_paciente.get("protocolo_dieta")
    prousocorticoide = data_protocolo_paciente.get("protocolo_corticosteroide")
    prodoencahepatica = data_protocolo_paciente.get("protocolo_doenca_hepatica")
    prosensibilidadeinsu = data_protocolo_paciente.get("protocolo_sensibilidade_insulina")
    proglicemiaatual= data_protocolo_paciente.get("protocolo_glicemia_atual")
    


@app.post("/cadPaciente")
def cadastrar_paciente():
    """ Cadastra novos pacientes """
    data_paciente = request.json

    if not data_paciente:
        return jsonify({
            "code" : 400,
            "message" : "Atenção : dados não informados!"}),
    
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
            "message" : f"{txt_retorno}"}),
    
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
            "message" : f"Usuario cadastrado com sucesso!"
        })
    except ValueError as e:
        return jsonify ({
            "code" : 500,
            "message" : f"Ocorreu um erro ao tentar registrar usuario"
        })

if __name__ == "__main__":
    app.run('127.0.0.1',5000)