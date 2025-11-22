import 'package:flutter/material.dart';
import 'package:insuguia/home.dart';
import 'package:insuguia/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  Future<void> validateUser(BuildContext context) async{
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/validUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_email" : controllerEmail.text,
        "senha_acesso" : controllerSenha.text
      }),
    );

    dynamic responseJson = jsonDecode(response.body);


    if (responseJson['code'] == 200){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    }
    else{
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Erro Ao Cadastrar Usuário'),
          content: Text(responseJson['message']),
          actions: [
            TextButton(
              onPressed: () =>{ 
                Navigator.pop(context)
              },  
              child: Text('Ok', style: TextStyle(color: Colors.blue[700]),),
            ),
          ],
        )); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.blue[700],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: ContinuousRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(10)))
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
        )
      ),
      home: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.all(40), 
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/Logo_2.png'),
                  height: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    label: Text('Email')
                  ),
                  controller: controllerEmail,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    label: Text('Senha')
                    
                  ),
                  controller: controllerSenha,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () => {
                    validateUser(context)
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(200, 32),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.blue[700]),
                    )
                  ),
                  SizedBox(height: 20,),
                  TextButton(
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()))
                    }, 
                    child: Text('Criar uma Conta.',
                      style: TextStyle(color: Colors.white),
                    )
                  )
                ],
            ),
          ),
        ),
        backgroundColor:Color.fromRGBO(13, 71, 161, 1),
      ),
    );
  }
}