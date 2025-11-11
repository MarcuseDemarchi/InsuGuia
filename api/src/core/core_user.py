import re
import random
import string
import hashlib
from ..infra.database import SessionLocal
from ..infra.database.models.user import User


class CoreUser():
    """  Classe responsável por gerenciar o core dos usuários """
    def __init__(self):        
        self.db_session = SessionLocal()

    @staticmethod
    def _generate_salt_string() -> str:
        """ Gera uma string aleatoria para gerar senha """
        characters = string.ascii_letters + string.digits
        random_string = "".join(random.choice(characters) for _ in range(len(characters)))
        
        return random_string
    
    @staticmethod
    def create_email_valid(email : str) -> tuple[bool,str]:
        with SessionLocal() as db:
            email_exist = db.query(User).where(User.usremail == email).first()

        if email_exist:
            return [False,"Atencao : O email ja esta cadastrado a um usuario!"]
        else:
            return [True,"Email nao encontrado"]

    @staticmethod
    def create_password_valid(password : str) -> tuple[bool,str]:
        """ 
        Valida a senha da pessoa :
        Regras:
        -> Tem que ter numero
        -> Letras maiusculas
        -> Pelo menos 1 caracter especial
        -> + que 8 caracteres
        """
        if len(password) < 8:
            return False, "A senha deve conter ao menos 8 caracteres"
        if not re.search(r"[A-Z]",password):
            return False, "A senha deve conter pelo menos 1 letra maiscula"
        if not re.search(r"\d",password):
            return False, "A senha deve conter numeros"
        if not re.search("[a-z]",password):
            return False, "A senha deve conter letras"
        if not re.search(r"\W",password):
            return False, "A senha deve conter caracteres especiais"
        
        return True, "Senha valida"

    @staticmethod
    def _hash_password(password : str, salt : str) -> str:
        """ Deixa a senha com hash utilizando a coluna salt """
        combined_string = password + salt
        encode_pass = combined_string.encode("utf-8")
        hashed = hashlib.sha256(encode_pass)

        return hashed.hexdigest()
    
    def create_user(self,usrnamefull : str , password : str,user_email : str):
        """ Cria um novo usuario caso todos os metodos estejam corretos"""
        random_salt = self._generate_salt_string()
        password_hashed = self._hash_password(password,random_salt)

        new_user = User(
            usrnamefull=usrnamefull,
            usrpassword=password_hashed,
            usremail=user_email,
            usrsalt=random_salt
        )

        with self.db_session as db:
            db.add(new_user)
            db.commit()
            db.refresh(new_user)
        
        return new_user

    def valid_user(self,usrmail : str, password : str) -> tuple[bool,str]:        
        with self.db_session as db:
            user = db.query(User).filter(User.usremail == usrmail).first()            

        if not user:
            return False, "Usuario nao encontrado"        
    
        hash_password = self._hash_password(password,user.usrsalt)

        if user.usrpassword != hash_password:
            return False, "Senha incorreta!"
        else:
            return True, "Acesso liberado!"