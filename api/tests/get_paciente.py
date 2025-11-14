import requests

url = "http://10.4.241.20:5000/getPacientes"

hearder = {"Content-Type": "application/json"}

response = requests.get(url=url,verify=False,headers=hearder)

print(response.text)