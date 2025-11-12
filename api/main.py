from flask import Flask,request,jsonify
from src.infra.database import Base,engine
import src.infra.database.models
from src.core.core_user import CoreUser

Base.metadata.create_all(bind=engine)

app = Flask(__name__)

@app.get("/")
def index():
    """ Function index do projeto """
    return "Api esta funcionando corretamente"

@app.post("/validUser")
def user_valid():
    """ Valida o acesso do usuário """
    fc_user = CoreUser()
    data_user = request.json

    if not data_user:
        return jsonify({"mensagem" : "Dados invalidos"})
    
    usrmail = data_user.get("usrmail")
    password = data_user.get("password")

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
        return jsonify({"message" : f"Ocorreu um erro ao tentar registrar usuario"})

if __name__ == "__main__":
    app.run('127.0.0.1',5000)