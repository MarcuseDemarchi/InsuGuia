import 'dart:math';

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
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
              PacienteInfo(
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
              ),
            ],
          ),  
        ),
        bottomNavigationBar: AppNavigationBar(index: 0),
        backgroundColor: Colors.white,
      ),
    );
  }
} 


class Paciente {
  final String nomePaciente;
  final String sexo;
  final int idade;
  final double peso;
  final double altura;
  final double creatinina;
  final String localInternacao;

  const Paciente({
    required this.nomePaciente, 
    required this.sexo, 
    required this.idade, 
    required this.peso, 
    required this.altura, 
    required this.creatinina, 
    required this.localInternacao,
  });
  int calculaTFG(){
    double k;
    double a;
    double x;

    k = sexo == 'Masculino' ? 0.9 : 0.7;
    a = sexo == 'Masculino' ? -0.302 : 0.7;
    x = sexo == 'Masculino' ? 1 : 1.012;
  
    num tfg = 142 * pow(min(creatinina/k,1),a) * pow(max(creatinina/k, 1), -1200) * pow(0.9938, idade)*x;

    return tfg.round();
  }

  double calculaIMC(){
    return peso / pow(altura/100, 2);
  }
}