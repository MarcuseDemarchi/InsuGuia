import requests

url = "http://127.0.0.1:5000/deletePaciente"
params = {"paccodigo": 8}
hearder = {"Content-Type": "application/json"}

response = requests.delete(url=url,params=params,verify=False,headers=hearder)

print(response.text)