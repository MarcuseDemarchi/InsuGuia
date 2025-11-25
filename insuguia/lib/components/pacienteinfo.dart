import 'package:flutter/material.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/paciente/pacientedetails.dart';

class PacienteInfo extends StatelessWidget{
  final Paciente paciente;

  const PacienteInfo({
    super.key, 
    required this.paciente
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteDetailsPage(paciente: paciente)));
          }, 
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10), side: BorderSide(color: Colors.black38))
            
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
            child: Row(
              spacing: 10,
              children: [
                Icon(Icons.personal_injury, color: Colors.blue[700], size: 36),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                    Text("${paciente.sexo} | ${paciente.idade} Anos", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black38),)
                  ],
                )  
              ],
            ),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}