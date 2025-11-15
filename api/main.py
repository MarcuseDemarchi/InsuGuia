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

@app.post("/cadPaciente")
def cadastrar_paciente():
    """ Cadastra novos pacientes """
    data_paciente = request.json

    if not data_paciente:
        return jsonify({"message" : "Atenção : dados não informados!"}),400
    
    pacname = data_paciente.get("paciente_nome")
    pacsexo = data_paciente.get("paciente_sexo")
    pacidade = data_paciente.get("paciente_idade")
    pacpeso = data_paciente.get("paciente_peso")
    pacaltura = data_paciente.get("paciente_altura")
    paccreatinina = data_paciente.get("paciente_creatinina")
    pacimc = data_paciente.get("paciente_imc")
    pactfg = data_paciente.get("paciente_tfg")

    pac_obj = CorePaciente(pacname,pacsexo,
                    pacidade, pacpeso,
                    pacaltura,paccreatinina,
                    pacimc,pactfg)
    
    data_paciente_valido,txt_retorno = pac_obj.valid_campos()

    if not data_paciente_valido:
        return jsonify({"message" : f"{txt_retorno}"}),400
    
    try:
        pac_obj.insert_paciente()
        return jsonify({"message" : "Paciente inserido com sucesso!"})
    except Exception as e:
        print(f"Erro ao inserir paciente: {e}")
        return jsonify({"message" : f"Erro interno ao inserir paciente: {e}"}), 500
    
@app.post("/validUser")
def user_valid():
    """ Valida o acesso do usuário """
    fc_user = CoreUser()
    data_user = request.json

    if not data_user:
        return jsonify({"mensagem" : "Dados não informados"})
    
    usrmail = data_user.get("user_email")
    password = data_user.get("senha_acesso")

    valid_user = fc_user.valid_user(usrmail,password)

    return jsonify({"mensagem" : f"{valid_user[1]}"})

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

    pass_valid = fc_user.create_password_valid(password)
    mail_valid = fc_user.create_email_valid(user_name_full)

    if not pass_valid[0]:
        return jsonify({"message" : pass_valid[1]})
    if not mail_valid[0]:
        return jsonify({"message" : mail_valid[1]})

    try:
        fc_user.create_user(
            usrnamefull=user_name_full,
            password=password,
            user_email=user_email
        )
        return jsonify({"message" : f"Usuario cadastrado com sucesso!"})
    except ValueError as e:
        return jsonify ({"message" : f"Ocorreu um erro ao tentar registrar usuario"})

if __name__ == "__main__":
    app.run('127.0.0.1',5000)