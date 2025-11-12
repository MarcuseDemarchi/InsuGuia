import requests

url = "http://127.0.0.1:5000/validUser"

params = {
    "user_email" : "demarchimarcu112s20014@gmail.com",
    "senha_acesso" : "Teste@123",
    }

hearder = {"Content-Type": "application/json"}

response = requests.post(url=url,json=params,
                         verify=False,headers=hearder)

print(response.text)