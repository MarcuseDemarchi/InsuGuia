from flask import Flask
from src.infra.database import Base,engine

Base.metadata.create_all(bind=engine)

app = Flask(__name__)

@app.get("/")
def index():
    return "Index page"

@app.post("/cadUser")
def cadastra_usuário():
    pass

@app.get("/getUser")
def hello_world():
    return True

if __name__ == "__main__":
    app.run('127.0.0.1',5000)