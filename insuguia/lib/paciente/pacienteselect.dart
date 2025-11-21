
import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/pacienteselectContainer.dart';
import 'package:insuguia/paciente/paciente.dart';

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
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.blue[700],),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))

              ),
            ),
            SizedBox(height: 20),
            PacienteSelectContainer(
              selectToProtocol: isProtocolo,
              paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'
              )
            ),
            PacienteSelectContainer(
              selectToProtocol: isProtocolo,
              paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'
              )
            ),
            PacienteSelectContainer(
              selectToProtocol: isProtocolo,
              paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'
              )
            ),
            PacienteSelectContainer(
              selectToProtocol: isProtocolo,
              paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'
              )
            ),
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 1),
      ),
    );
  }
}