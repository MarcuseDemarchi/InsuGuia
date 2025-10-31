import re
import random
import string
import hashlib


class CoreUser():
    """  Classe responsável por gerenciar o core dos usuários """
    def __init__(self):        
        pass

    @staticmethod
    def generate_salt_string() -> str:
        """ Gera uma string aleatoria para gerar senha """
        characters = string.ascii_letters + string.digits
        random_string = "".join(random.choice(characters) for _ in range(len(characters)))
        return random_string
    
    @staticmethod
    def password_valid(password : str) -> bool:
        """ 
        Valida a senha da pessoa :
        Regras:
        -> Tem que ter numero
        -> Letras maiusculas
        -> Pelo menos 1 caracter especial
        -> + que 8 caracteres
        """
        if len(password) < 8:
            return False
        if not re.search(r"[A-Z]",password):
            return False
        if not re.search(r"\d",password):
            return False
        if not re.search("[a-z]",password):
            return False
        if not re.search(r"\W",password):
            return False
        
        return True

    @staticmethod
    def hash_password(password_valid : str, salt : str) -> str:
        """ Deixa a senha com hash utilizando a coluna salt """
        combined_string = password_valid + salt
        hashed = hashlib.sha256(combined_string.encode("utf-8").hex())
        return hashed