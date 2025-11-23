import requests

url = "http://127.0.0.1:5000/updatePaciente/10"

params = {
    "paciente_nome" : "Davi Jefferson Chiquetti",
    "paciente_sexo" : "Masculino",
    "paciente_idade" : 10,
    "paciente_peso" : 10,
    "paciente_altura" : 10.1,
    "paciente_creatinina" : 10,
    "paciente_imc" : 10,
    "paciente_tfg" : 10,
    "paciente_localinternacao" : "Enfermaria"
    }

hearder = {"Content-Type": "application/json"}

response = requests.put(url=url,json=params,
                         verify=False,headers=hearder)
print(response.text)