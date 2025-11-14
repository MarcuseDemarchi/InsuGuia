import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/pacientedetails.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/protocolo/protocolodetails.dart';

class PrescricaoDetailsPage extends StatelessWidget{
  final Prescricao prescricao;

  const PrescricaoDetailsPage({
    super.key,
    required this.prescricao,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(25, 118, 210, 1))
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.arrow_back, color: Colors.white,)
              ),
              Text('Detalhes', style: TextStyle(color: Colors.white))
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  side: BorderSide(color: Colors.black38)
                )
              ),
              onPressed: (){
              }, 
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.medication_rounded, color: Colors.blue[700], size: 36,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prescrição #${prescricao.id}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                        Text("${prescricao.dataEmissao.day}/${prescricao.dataEmissao.month}/${prescricao.dataEmissao.year}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        side: BorderSide(color: Colors.black38)
                      )
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Protocolodetails(protocolo: prescricao.protocolo)));
                    }, 
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.medical_information, color: Colors.blue[700], size: 36,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Protocolo #${prescricao.protocolo.id}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              Text("${prescricao.protocolo.dataEmissao.day}/${prescricao.protocolo.dataEmissao.month}/${prescricao.protocolo.dataEmissao.year}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        side: BorderSide(color: Colors.black38)
                      )
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteDetailsPage(paciente: prescricao.protocolo.paciente)));
                    }, 
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.personal_injury, color: Colors.blue[700], size: 36,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(prescricao.protocolo.paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              Text("${prescricao.protocolo.paciente.idade} Anos | ${prescricao.protocolo.paciente.sexo}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 3),
        backgroundColor: Colors.white,
      ),
    );
  }
}