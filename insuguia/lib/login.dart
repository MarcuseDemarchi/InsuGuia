import 'package:flutter/material.dart';
import 'package:insuguia/register.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    label: Text('Senha')
                    
                  ),
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {}, 
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