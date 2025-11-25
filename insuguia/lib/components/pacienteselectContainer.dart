import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insuguia/acompanhamento/acompanhamento.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/protocolo/protocolocadastrar.dart';

import 'package:http/http.dart' as http;

class PacienteSelectContainer extends StatelessWidget{
  const PacienteSelectContainer({super.key, required this.paciente, required this.selectToProtocol});
  
  final Paciente paciente;
  final bool selectToProtocol;

  Future<void> getLastPrescricao(BuildContext context) async{
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/getUltimaPrescricao/${paciente.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var prescricao = Prescricao.fromJson(jsonDecode(response.body)); 

      Navigator.push(context, MaterialPageRoute(builder: (context) => AcompanhamentoPage(paciente: paciente, prescricao: prescricao,)));
    }
  }

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
              if (selectToProtocol) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProtocoloCadastrarPage(paciente: paciente)))
              } else {
                getLastPrescricao(context)
              }
            },
            style: IconButton.styleFrom(backgroundColor: Colors.blue[700]),
            icon: Icon(Icons.arrow_forward, color: Colors.white,)
          ),
        ],
      ),
    );
  }
}