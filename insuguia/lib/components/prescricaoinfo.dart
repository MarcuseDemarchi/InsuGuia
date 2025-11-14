import 'package:flutter/material.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/prescricao/prescricaodetails.dart';

class PrescricaoInfo extends StatelessWidget{
  final Prescricao prescricao;
  
  const PrescricaoInfo({
    super.key,
    required this.prescricao,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
          side: BorderSide(color: Colors.black38)
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PrescricaoDetailsPage(prescricao: prescricao)));
      },
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
        child: Row(
          children: [
            Icon(Icons.medication_rounded, color: Colors.blue[700], size: 36),
            Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prescrição #${prescricao.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  Text(prescricao.protocolo.paciente.nomePaciente, style: TextStyle(color: Colors.black38, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${prescricao.dataEmissao.day}/${prescricao.dataEmissao.month}/${prescricao.dataEmissao.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                Text(''),
              ],
            )
          ],
        ),
      )
    );
  }
}