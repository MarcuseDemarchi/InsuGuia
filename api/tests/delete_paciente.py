import requests

url = "http://127.0.0.1:5000/deletePaciente/7"
hearder = {"Content-Type": "application/json"}

response = requests.delete(url=url,verify=False,headers=hearder)

print(response.text)