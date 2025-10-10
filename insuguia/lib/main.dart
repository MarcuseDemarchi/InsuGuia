import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: ContinuousRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(10)))
          )
        )
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/Logo.png'),
                height: 200,
              ),
              ElevatedButton(
                onPressed: press,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: Size(200, 32),
                ),
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.blue[700]
                  ),
                )
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: press,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  fixedSize: Size(200, 32),
                ),
                child: Text(
                  'Cadastrar-se',
                  style: TextStyle(color: Colors.white),
                )
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(13, 71, 161, 1),
      ),
    );
  }
}


void press(){
  
}