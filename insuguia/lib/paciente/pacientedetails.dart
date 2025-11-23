import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/paciente/pacienteeditar.dart';
import 'package:insuguia/protocolo/protocolocadastrar.dart';

class PacienteDetailsPage extends StatelessWidget{
  final Paciente paciente;
  
  const PacienteDetailsPage({
    super.key,
    required this.paciente,
  });

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
                            Text(paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("${paciente.sexo} | ${paciente.idade} Anos"),
                          ],
                        ),
                      ],
                    ),
                    
                    IconButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteEditarPage(paciente: paciente,)))
                      }, 
                      icon: Icon(Icons.edit, color: Colors.blue[700],))
                  ],
                ),
              ),
              Text(paciente.id.toString()),
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
                        InfoContainerWithTitle(icon: Icons.scale, title: ' Peso', value: ' ${paciente.peso} kg'),
                        InfoContainerWithTitle(icon: Icons.height, title: ' Altura', value: '${paciente.altura/100} m'),
                      ],
                    ),
                    Row(
                      children: [
                        InfoContainerWithTitle(icon: Icons.bed, title: " Local de Internação", value: paciente.localInternacao),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoContainerWithTitle(icon: Icons.science_rounded, title: ' Creatinina', value: "${paciente.creatinina} mg/dL"),
                        InfoContainerWithTitle(icon: Icons.fitness_center_rounded, title: ' IMC', value: "${paciente.calculaIMC().toStringAsFixed(1)} kg/m²"),
                      ],  
                    ),
                    Row(
                      children: [
                        InfoContainerWithTitle(icon: Icons.calculate_rounded, title: ' TFG (CKD-EPI 2021)', value: "${paciente.calculaTFG().toStringAsFixed(0)} mL/min/1,73m²"),
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
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProtocoloCadastrarPage(paciente: paciente)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                              ),
                              child: Text(
                                "Realizar Protocolo",
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