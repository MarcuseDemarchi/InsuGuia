import requests

url = "http://127.0.0.1:5000/getProtocolo?procodigo=1"

headers = {"Content-Type": "application/json"}

response = requests.get(url, headers=headers, verify=False)
print("\n=== RESPOSTA GET PROTOCOLO ===")
print(response.text)