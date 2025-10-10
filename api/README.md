# InsuGuia API (Back-end)

## 🩺 Sobre
O **InsuGuia API** é o back-end do projeto acadêmico **InsuGuia**, desenvolvido em **Python (Flask)**.  
Fornece uma **API REST** para o aplicativo móvel, responsável pelos cálculos e regras de prescrição de insulina em pacientes hospitalizados **não críticos**.

---

## ⚙️ Tecnologias
- Python 3.11+
- Flask
- Flask-SQLAlchemy
- PostgreSQL
- python-dotenv

---

### 1. Clonar o Repositório
```bash
git clone https://github.com/MarcuseDemarchi/InsuGuia.git
cd insuguia-api
```

### 2. Instalar Dependências
```
python -m venv venv
source venv/bin/activate  # Linux / Mac
venv\Scripts\activate     # Windows
pip install -r requirements.txt
```

### 3. Configurar .env
FLASK_APP=run.py
FLASK_ENV=development
DATABASE_URL=postgresql://usuario:senha@localhost:5432/insuguia

## Desenvolvedor
Marcus André Geacomo Demarchi
Disciplina: Desenvolvimento de Plataformas Móveis
Curso: Sistemas de Informação — 6ª Fase