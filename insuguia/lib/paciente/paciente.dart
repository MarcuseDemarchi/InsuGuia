import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';

class PacientePage extends StatelessWidget{
  const PacientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[700],
          onPressed: () => {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),  
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              Icon(Icons.personal_injury, color: Colors.white,),
              Text(' Pacientes', style: TextStyle(color: Colors.white)),
            ],
          )
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: ListView(
            children: [
              
            ],
          ),  
        ),
        bottomNavigationBar: AppNavigationBar(index: 0),
      ),
    );
  }
} 