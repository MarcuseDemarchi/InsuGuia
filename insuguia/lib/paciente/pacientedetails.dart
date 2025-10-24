import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/pacienteinfo.dart';
import 'package:insuguia/paciente/paciente.dart';

class PacienteDetailsPage extends PacienteInfo{
  const PacienteDetailsPage({
    super.key,
    required super.nomePaciente, 
    required super.sexo, 
    required super.idade, 
    required super.peso, 
    required super.altura,
    required super.creatinina, 
    required super.localInternacao,
  });

  double calculaTFG(){
    double k;
    double a;
    double x;

    if (sexo == 'Masculino'){
      k = 0.9;
      a = 0.302;
      x = 1;
    }
    else{
      k = 0.7;
      a = 0.241;
      x = 1.012;
    }

    num tfg = 142 * pow(min(creatinina/k,1),a) * pow(max(creatinina/k, 1), 1200) * pow(0.9938, idade)*x;

    return tfg.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PacientePage()))
                },
                icon: Icon(Icons.arrow_back), 
                color: Colors.white,),
              Text(nomePaciente, style: TextStyle(color: Colors.white)),
            ],  
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text(nomePaciente),
              Text(sexo),
              Text(idade.toString()),
              Text(peso.toString()),
              Text(altura.toString()),
              Text(creatinina.toString()),
              Text(localInternacao.toString()),
              Text((peso / ((altura / 100) * (altura / 100))).toStringAsFixed(1)),
              Text(calculaTFG().toString()),
            ],
          ),
        ),
        bottomNavigationBar: AppNavigationBar(index: 0),
      ),
    );
  }
}