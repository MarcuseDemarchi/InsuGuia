import requests
import time

BASE = "http://127.0.0.1:5000"
url = f"{BASE}/gerarPrescricao"

payload = {"procodigo": 1}
headers = {"Content-Type": "application/json"}

r = requests.post(url, json=payload, headers=headers, verify=False)
print("STATUS:", r.status_code)
print(r.text)
