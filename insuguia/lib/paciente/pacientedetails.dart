import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/pacienteinfo.dart';
import 'package:insuguia/paciente/pacienteeditar.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.blue[700],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10)
            ),
          ),
        ),
      ),
      home: Scaffold(
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
              Text('Detalhes', style: TextStyle(color: Colors.white)),
            ],  
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.personal_injury,
                          color: Colors.blue[700],
                          size: 48,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nomePaciente, style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("$sexo | $idade Anos"),
                          ],
                        ),
                      ],
                    ),
                    
                    IconButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteEditarPage(nomePaciente: nomePaciente, sexo: sexo, idade: idade, peso: peso, altura: altura, creatinina: creatinina, localInternacao: localInternacao)))
                      }, 
                      icon: Icon(Icons.edit, color: Colors.blue[700],))
                  ],
                ),
              ),
              Divider(height: 1,),
              Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Column(
                  children: [
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoContainerWithTitle(icon: Icons.scale, title: ' Peso', value: ' $peso kg'),
                        InfoContainerWithTitle(icon: Icons.height, title: ' Altura', value: '${altura/100} m'),
                      ],
                    ),
                    Row(
                      children: [
                        InfoContainerWithTitle(icon: Icons.bed, title: " Local de Internação", value: localInternacao),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoContainerWithTitle(icon: Icons.science_rounded, title: ' Creatinina', value: "$creatinina mg/dL"),
                        InfoContainerWithTitle(icon: Icons.fitness_center_rounded, title: ' IMC', value: "${calculaIMC().toStringAsFixed(1)} kg/m²"),
                      ],  
                    ),
                    Row(
                      children: [
                        InfoContainerWithTitle(icon: Icons.calculate_rounded, title: ' TFG (CKD-EPI 2021)', value: "${calculaTFG().toStringAsFixed(0)} mL/min/1,73m²"),
                      ],
                    ),
                    Row(
                      children: [
                        InfoContainerWithTitle(icon: Icons.label, title: ' Classificação Clínica', value: 'Não crítico')
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsGeometry.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                              ),
                              child: Text(
                                "Realizar Prescrição",
                                style: TextStyle(color: Colors.white),
                              )
                            ),
                          ),
                        ),
                      ],
                    )
                    
                  ],
                ),
              ),
              // Text(nomePaciente),
              // Text(sexo),
              // Text(idade.toString()),
              // Text(peso.toString()),
              // Text(altura.toString()),
              // Text(creatinina.toString()),
              // Text(localInternacao.toString()),
              // Text((peso / ((altura / 100) * (altura / 100))).toStringAsFixed(1)),
              // Text(calculaTFG().toString()),
            ],
          ),
        ),
        bottomNavigationBar: AppNavigationBar(index: 0),
        backgroundColor: Colors.white,
      ),
    );
  }
}


//
//
//
//
//
//
//
//
class InfoContainerWithTitle extends StatelessWidget{
  final IconData icon;
  final String title;
  final String value;

  const InfoContainerWithTitle({
    super.key, 
    required this.icon, 
    required this.title, 
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue[700],
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(height: 1,),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 10),
              child: Text(
                value,
              ),
            ),
          ],
        ),
      ) 
    );
  }
}