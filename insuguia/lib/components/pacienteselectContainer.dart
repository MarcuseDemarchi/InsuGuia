import 'package:flutter/material.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/protocolo/protocolocadastrar.dart';

class PacienteSelectContainer extends StatelessWidget{
  const PacienteSelectContainer({super.key, required this.paciente});
  
  final Paciente paciente;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.personal_injury, size: 36, color: Colors.blue[700],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("${paciente.idade} Anos | ${paciente.sexo}", style: TextStyle(fontStyle: FontStyle.italic),)
                  ],
                ),
              ],
            )
          ),
          IconButton.filled(
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProtocoloCadastrarPage(paciente: paciente)))
            },
            style: IconButton.styleFrom(backgroundColor: Colors.blue[700]),
            icon: Icon(Icons.arrow_forward, color: Colors.white,)
          ),
        ],
      ),
    );
  }
}