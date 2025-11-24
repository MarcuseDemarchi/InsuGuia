import requests

url = "http://127.0.0.1:5000/cadProtocolo"

params = {    
    "paciente_codigo": 1,             
    "protocolo_dieta": "oral",                  
    "protocolo_corticosteroide": "nao",         
    "protocolo_doenca_hepatica": False,
    "protocolo_sensibilidade_insulina": "50",     
    "protocolo_glicemia_atual": 220,
    "protocolo_escala_dispositivo": 1,
    "protocolo_tipo_insulina_basal": "Lantus",
    "protocolo_posologia_basal": "10UI as 22h",
    "protocolo_insulina_rapida": "Novorapid"
}

headers = {"Content-Type": "application/json"}

try:
    response = requests.post(url, json=params, headers=headers, verify=False)
    print("\n=== RESPOSTA CADASTRO PROTOCOLO ===")
    print(f"Status Code: {response.status_code}")
    print("Body:", response.text)
except requests.exceptions.ConnectionError:
    print("Erro: Não foi possível conectar à API. Verifique se o servidor Flask está rodando.")