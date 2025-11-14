import requests

url = "http://127.0.0.1:5000/cadUser"

params = {
    "user_name_full" : "teste_marcus",
    "password" : "Aesaaat123e@",
    "user_email" : "demarchimarcu112s20014@gmail.com"
    }

hearder = {"Content-Type": "application/json"}

response = requests.post(url=url,json=params,
                         verify=False,headers=hearder)
print(response.text)