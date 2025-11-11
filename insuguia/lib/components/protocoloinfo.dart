import 'package:flutter/material.dart';

class ProtocoloInfo extends StatelessWidget{
  const ProtocoloInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        spacing: 10,
        children: [
          Icon(Icons.medical_information, color: Colors.blue[700], size: 36),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paciente: Teste', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Protocolo #1925', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black38),),
                  Text('Emitido 11/11/2025', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black38),)
                ],
              )  
            ],
          ),
        ],
      ),
    );
  }
}