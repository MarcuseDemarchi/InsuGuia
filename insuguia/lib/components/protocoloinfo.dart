import 'package:flutter/material.dart';
import 'package:insuguia/protocolo/protocolo.dart';
import 'package:insuguia/protocolo/protocolodetails.dart';

class ProtocoloInfo extends StatelessWidget{
  final Protocolo protocolo;

  const ProtocoloInfo({super.key, required this.protocolo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Protocolodetails(protocolo: protocolo)));
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
                Icon(Icons.medical_information, color: Colors.blue[700], size: 36),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(protocolo.paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text('Prot. #${protocolo.id} | Emitido ${protocolo.dataEmissao.day}/${protocolo.dataEmissao.month}/${protocolo.dataEmissao.year}', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black38),),
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