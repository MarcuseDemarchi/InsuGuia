
import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/listapacientes.dart';

class PacienteSelectPage extends StatelessWidget{
  final bool isProtocolo; 

  const PacienteSelectPage({
    super.key, 
    required this.isProtocolo
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blue[700]),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(
                onPressed: () => {
                  Navigator.pop(context)
                }, 
                icon: Icon(Icons.arrow_back, color: Colors.white,)
              ),
              Text('Selecionar Paciente', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.blue[700],),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20),
              Expanded(child: ListaPacientes(select: true, selectToProtocol: isProtocolo)),
            ],
          )
        ),
        bottomNavigationBar: AppNavigationBar(index: 1),
      ),
    );
  }
}