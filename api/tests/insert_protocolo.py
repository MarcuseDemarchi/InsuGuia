import requests

url = "http://127.0.0.1:5000/cadProtocolo"

params = {    
    "paciente_codigo": 1,             
    "protocolo_dieta": "oral",                  
    "protocolo_corticosteroide": "nao",         
    "protocolo_doenca_hepatica": False,
    "protocolo_sensibilidade_insulina": None,
    "protocolo_glicemia_atual": 220,
    "protocolo_escala_dispositivo": 1
}

headers = {"Content-Type": "application/json"}

response = requests.post(url, json=params, headers=headers, verify=False)
print("\n=== RESPOSTA CADASTRO PROTOCOLO ===")
print(response.text)
