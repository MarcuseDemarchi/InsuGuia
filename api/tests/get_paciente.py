import requests

url = "http://127.0.0.1:5000/getPacientes"

hearder = {"Content-Type": "application/json"}

response = requests.get(url=url,verify=False,headers=hearder)

print(response.text)