import 'package:flutter/material.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/paciente/pacientedetails.dart';

class PacienteInfo extends StatelessWidget{
  final Paciente paciente;

  const PacienteInfo({super.key, required this.paciente});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.personal_injury, color: Colors.blue[700], size: 36,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("${paciente.sexo} | ${paciente.idade} Anos", style: TextStyle(fontStyle: FontStyle.italic),)
                      ],
                    ),
                  ],  
                )
              ],
            )
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteDetailsPage(paciente: paciente,)))
                  },
                  icon: Icon(
                    Icons.medical_information,
                    color: Colors.blue[700],  
                  ),  
                )
              ],
            )
          )
        ],
      ),
    );
  }
}