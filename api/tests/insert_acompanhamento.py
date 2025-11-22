import requests

BASE = "http://127.0.0.1:5000"

data = {
    "paciente_codigo": 1,
    "glicemia_jejum": 190,
    "glicemia_pre_almoco": 210,
    "glicemia_pre_jantar": 200,
    "glicemia_22h": 170,
    "ajustes": "Elevar basal em 10%"
}

print("\n=== CADASTRANDO ACOMPANHAMENTO ===")
r = requests.post(f"{BASE}/cadAcompanhamento", json=data)
print(r.text)

# --- Consulta último acompanhamento ---
print("\n=== BUSCANDO ÚLTIMO ACOMPANHAMENTO ===")
r = requests.get(f"{BASE}/getAcompanhamentoUltimo?paccodigo=1")
print(r.text)
