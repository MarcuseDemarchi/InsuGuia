import requests

url = "http://10.4.241.20:5000/cadPaciente"

params = {
    "paciente_nome" : "Marcus Demarchi",
    "paciente_sexo" : "Masculino",
    "paciente_idade" : 10,
    "paciente_peso" : 10,
    "paciente_altura" : 10.1,
    "paciente_creatinina" : 10,
    "paciente_imc" : 10,
    "paciente_tfg" : 10
    }

hearder = {"Content-Type": "application/json"}

response = requests.post(url=url,json=params,
                         verify=False,headers=hearder)
print(response.text)