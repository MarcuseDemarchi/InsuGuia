from flask import Flask,request,jsonify
from src.infra.database import Base,engine
import src.infra.database.models

Base.metadata.create_all(bind=engine)

app = Flask(__name__)

@app.get("/")
def index():
    """ Function index do projeto """
    return "Api esta funcionando corretamente"

@app.post("/validUser")
def user_valid():
    """ Valida o acesso do usuário """
    pass

@app.post("/cadUser")
def user_register():
    """ Cadastra o usuário dentro do sistema """
    response = request.json()

if __name__ == "__main__":
    app.run('127.0.0.1',5000)