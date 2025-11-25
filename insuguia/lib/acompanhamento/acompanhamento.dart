import 'package:flutter/material.dart';
import 'package:insuguia/acompanhamento/acompanhamentoResults.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/paciente/pacienteselect.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/prescricao/prescricaodetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AcompanhamentoPage extends StatelessWidget{
  final Paciente? paciente;
  final Prescricao? prescricao;

  AcompanhamentoPage({
    super.key, 
    this.paciente,
    this.prescricao,
  });

  final TextEditingController controllerJejum = TextEditingController();
  final TextEditingController controllerPreAlmoco = TextEditingController();
  final TextEditingController controllerPreJantar = TextEditingController();
  final TextEditingController controllerNoite = TextEditingController();

  Future<void> createAcompanhamento(BuildContext context) async{
    var response = await http.post(
      Uri.parse('http://127.0.0.1:5000/cadAcompanhamento'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{    
        "paciente_codigo" : paciente!.id,
        "glicemia_jejum" : int.parse(controllerJejum.text),
        "glicemia_pre_almoco" : int.parse(controllerPreAlmoco.text),
        "glicemia_pre_jantar" : int.parse(controllerPreJantar.text),
        "glicemia_22h": int.parse(controllerNoite.text),
      }),
    );

    dynamic responseJson = jsonDecode(response.body);

    Navigator.push(context, MaterialPageRoute(builder: (context) => AcompanhamentoResultsPage(paciente: paciente!, prescricao: prescricao!, ajustes: responseJson['ajustes'],)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(25, 118, 210, 1)),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(onPressed: () => {
                Navigator.pop(context)
              }, 
              icon: Icon(Icons.arrow_back, color: Colors.white)
              ),
              Text('Acompanhamento', style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteSelectPage(isProtocolo: false)));
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
                              Text('${paciente != null ? paciente?.nomePaciente : 'Selecione o Paciente'}' , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              Text(paciente != null ? "${paciente?.idade} Anos | ${paciente?.sexo}" : "", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
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
                      if (prescricao != null){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrescricaoDetailsPage(prescricao: prescricao!)));
                      }
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
                              Text(prescricao != null ? 'Prescrição #${prescricao?.id}' : 'Prescrição', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              Text(prescricao != null ? "${prescricao?.dataEmissao.day}/${prescricao?.dataEmissao.month}/${prescricao?.dataEmissao.year}" : '--/--/----', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
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
            InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                label: Text('Glicemias de ontem', style: TextStyle(color: Colors.blue[700])),                
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              child: Column(
                spacing: 10,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: controllerJejum,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      label: Text('Jejum', style: TextStyle(color: Colors.blue[700]),),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: controllerPreAlmoco,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      label: Text('Pré-Almoço', style: TextStyle(color: Colors.blue[700]),),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: controllerPreJantar,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      label: Text('Pré-Jantar', style: TextStyle(color: Colors.blue[700]),),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: controllerNoite,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      label: Text('22h', style: TextStyle(color: Colors.blue[700]),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (paciente != null){
                  createAcompanhamento(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5)
                )
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 10, bottom: 10),
                child: Text(
                  "Sugerir Ajustes",
                  style: TextStyle(color: Colors.white),
                )
              )
            ),
            
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 4),
      ),
    );
  }
}

class Acompanhamento {
  final Prescricao prescricao;
  final DateTime dataAcompanhamento;

  const Acompanhamento({
    required this.prescricao,
    required this.dataAcompanhamento
  });
}