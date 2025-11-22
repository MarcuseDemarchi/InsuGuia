import requests

BASE = "http://127.0.0.1:5000"
params = {"precodigo": 1}
r = requests.get(f"{BASE}/getPrescricao", params=params, verify=False)
print("STATUS:", r.status_code)
print(r.text)