import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/pacienteinfo.dart';
import 'package:insuguia/paciente/pacientecadastrar.dart';

class PacientePage extends StatelessWidget{
  const PacientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blue[700]),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[700],
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteCadastrarPage()))
          },
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
              IconButton(
                onPressed: () => {
                    Navigator.pop(context),
                },
                icon: Icon(Icons.arrow_back), 
                color: Colors.white,),
              Text(' Pacientes', style: TextStyle(color: Colors.white)),
            ],
          )
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: ListView(
            children: [
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              PacienteInfo(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
            ],
          ),  
        ),
        bottomNavigationBar: AppNavigationBar(index: 0),
        backgroundColor: Colors.white,
      ),
    );
  }
} 