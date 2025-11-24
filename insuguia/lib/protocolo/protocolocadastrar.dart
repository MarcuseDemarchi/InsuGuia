import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/paciente.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProtocoloCadastrarPage extends StatelessWidget{
  final Paciente paciente;

  ProtocoloCadastrarPage({
    super.key,
    required this.paciente,
  });

  final TextEditingController controllerDieta = TextEditingController();
  final TextEditingController controllerCorticoide = TextEditingController();
  final TextEditingController controllerHepatica = TextEditingController();
  final TextEditingController controllerSensibilidade = TextEditingController();
  final TextEditingController controllerUltimaGlicemia = TextEditingController();
  final TextEditingController controllerEscala = TextEditingController();
  final TextEditingController controllerTipoBasal = TextEditingController();
  final TextEditingController controllerPosologia = TextEditingController();
  final TextEditingController controllerTipoRapida = TextEditingController();
  final TextEditingController controllerBolus = TextEditingController();
  

  Future<void> saveProtocolAndGeneratePrescription(BuildContext context)async {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:5000/cadProtocolo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{    
        "paciente_codigo": paciente.id,             
        "protocolo_dieta": controllerDieta.text,                  
        "protocolo_corticosteroide": controllerCorticoide.text,         
        "protocolo_doenca_hepatica": controllerHepatica.text == 'Sim',
        "protocolo_sensibilidade_insulina": controllerSensibilidade.text,     
        "protocolo_glicemia_atual": int.parse(controllerUltimaGlicemia.text),
        "protocolo_escala_dispositivo": double.parse(controllerEscala.text),
        "protocolo_tipo_insulina_basal": controllerTipoBasal.text,
        "protocolo_posologia_basal": controllerPosologia.text,
        "protocolo_insulina_rapida": controllerTipoRapida.text  
        }),
      );

    dynamic responseJson = jsonDecode(response.body);

    if (responseJson['code'] == 201){
      var responsePrescricao = await http.post(
      Uri.parse('http://127.0.0.1:5000/gerarPrescricao'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    
      body: jsonEncode(<String, dynamic>{    
        "procodigo": responseJson['procodigo'],        
        }),
      );

      dynamic responsePrescricaoJson = jsonDecode(responsePrescricao.body);

      if (responsePrescricaoJson['code'] == 201){
        showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Cadastro de protocolo'),
          content: Text('Prescrição gerada com sucesso!'),
          actions: [
            TextButton(
              onPressed: () => { 
                Navigator.push(context, MaterialPageRoute(builder: (context) => PacientePage()))
              },  
              child: Text('Ok', style: TextStyle(color: Colors.blue[700]),),
            ),
          ],
        )); 
      } 
      else{
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Erro Ao Cadastrar Protocolo'),
            content: Text(responsePrescricaoJson['message']),
            actions: [
              TextButton(
                onPressed: () =>{ 
                  Navigator.pop(context)
                },  
                child: Text('Ok', style: TextStyle(color: Colors.blue[700]),),
              ),
            ],
          )); 
      }
    }
    else{
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Erro Ao Cadastrar Protocolo'),
          content: Text(responseJson['message']),
          actions: [
            TextButton(
              onPressed: () =>{ 
                Navigator.pop(context)
              },  
              child: Text('Ok', style: TextStyle(color: Colors.blue[700]),),
            ),
          ],
        )); 
    }
  }

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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromRGBO(25, 118, 210, 1), width: 2)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(25, 118, 210, 1), width: 2)
          )
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(
                onPressed: () => {
                  Navigator.pop(context)
                }, 
                icon: Icon(Icons.arrow_back, color: Colors.white,)
              ),
              Text('Realizar Protocolo', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text(
              '1. Dados Clínicos', 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: Colors.blue[700],
              ),
            ),
            SizedBox(height: 20),
            DropdownMenu(
              width: double.infinity,
              enableFilter: true,
              controller: controllerDieta,
              label: Text('Dieta', style: TextStyle(color: Colors.blue[700])),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'oral_boa', label: 'Oral - Boa aceitação'),
                DropdownMenuEntry(value: 'oral_mal', label: 'Oral - Má aceitação'),
                DropdownMenuEntry(value: 'enteral', label: 'Enteral'),
                DropdownMenuEntry(value: 'parenteral', label: 'Parenteral'),
                DropdownMenuEntry(value: 'npo', label: 'NPO'),
              ]                    
            ),
            SizedBox(height: 20),
            DropdownMenu(
              width: double.infinity,
              enableFilter: true,
              controller: controllerCorticoide,
              label: Text('Uso de Corticoide', style: TextStyle(color: Colors.blue[700])),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'nao', label: 'Não'),
                DropdownMenuEntry(value: 'prednisona_baixa', label: 'Prednisona Baixa'),
                DropdownMenuEntry(value: 'prednisona_media', label: 'Prednisona Média'),
                DropdownMenuEntry(value: 'alta', label: 'Prednisona Alta'),
              ]                    
            ),
            SizedBox(height: 20),
            DropdownMenu(
              width: double.infinity,
              enableFilter: true,
              controller: controllerHepatica,
              label: Text('Doença Hepática', style: TextStyle(color: Colors.blue[700])),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'nao', label: 'Não'),
                DropdownMenuEntry(value: 'sim', label: 'Sim'),
              ]                    
            ),
            SizedBox(height: 20),
            DropdownMenu(
              width: double.infinity,
              enableFilter: true,
              controller: controllerSensibilidade,
              label: Text('Sensibilidade a insulina', style: TextStyle(color: Colors.blue[700])),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'baixa', label: 'Sensível'),
                DropdownMenuEntry(value: 'media', label: 'Usual'),
                DropdownMenuEntry(value: 'alta', label: 'Resistente'),
              ]                    
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerUltimaGlicemia,
              decoration: InputDecoration(
                label: Text('Última glicemia capilar (mg/dL)', style: TextStyle(color: Colors.blue[700]),),
              ),
            ),

            SizedBox(height: 40),
            Text(
              '2. Insulinas', 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: Colors.blue[700],
              ),
            ),
            SizedBox(height: 20),
            DropdownMenu(
              width: double.infinity,
              enableFilter: true,
              controller: controllerEscala,
              label: Text('Escala (UI) do dispositivo', style: TextStyle(color: Colors.blue[700])),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 0.5, label: '0.5'),
                DropdownMenuEntry(value: 1, label: '1'),
                DropdownMenuEntry(value: 2, label: '2'),
                // TODO: ao selecionar 2 -> mensagem de insulina arredondada em pares 
              ]                    
            ),
            SizedBox(height: 20),
            InputDecorator(
              decoration: InputDecoration(
                label: Text('Insulina basal', style: TextStyle(color: Colors.blue[700])),                
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Column(
                  children: [
                    DropdownMenu(
                      width: double.infinity,
                      enableFilter: true,
                      controller: controllerTipoBasal,
                      label: Text('Tipo', style: TextStyle(color: Colors.blue[700])),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 'nph', label: 'NPH'),
                        DropdownMenuEntry(value: 'glargina', label: 'Glargina'),
                        DropdownMenuEntry(value: 'degludeca', label: 'Degludeca'),
                      ]                    
                    ),  
                    SizedBox(height: 20),
                    DropdownMenu(
                      width: double.infinity,
                      enableFilter: true,
                      controller: controllerPosologia,
                      label: Text('Posologia', style: TextStyle(color: Colors.blue[700])),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: '1_manha', label: '1 Dose - 06h'),
                        DropdownMenuEntry(value: '1_noite', label: '1 Dose - 22h'),
                        DropdownMenuEntry(value: '2_manha_almoco', label: '2 Doses - 06h e 11h'),
                        DropdownMenuEntry(value: '2_manha_noite', label: '2 Doses - 06h e 22h'),
                        DropdownMenuEntry(value: '3_manha_almoco_noite', label: '3 Doses - 06h, 11h e 22h'),
                      ]                    
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            InputDecorator(
              decoration: InputDecoration(
                label: Text('Insulina de ação rápida', style: TextStyle(color: Colors.blue[700])),                
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Column(
                  children: [
                    DropdownMenu(
                      width: double.infinity,
                      enableFilter: true,
                      controller: controllerTipoRapida,
                      label: Text('Tipo', style: TextStyle(color: Colors.blue[700])),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 'regular', label: 'Regular'),
                        DropdownMenuEntry(value: 'lispro', label: 'Lispro'),
                        DropdownMenuEntry(value: 'aspart', label: 'Aspart'),
                        DropdownMenuEntry(value: 'glulisina', label: 'Glulisina'),
                      ]                    
                    ),  
                    SizedBox(height: 20),
                    DropdownMenu(
                      width: double.infinity,
                      enableFilter: true,
                      controller: controllerBolus,
                      label: Text('Bolus prandial a partir de:', style: TextStyle(color: Colors.blue[700])),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: '70', label: '70 mg/dL'),
                        DropdownMenuEntry(value: '100', label: '100 mg/dL'),
                        DropdownMenuEntry(value: '140', label: '140 mg/dL'),
                      ]                    
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                saveProtocolAndGeneratePrescription(context);
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
                  "Gerar prescrição sugerida",
                  style: TextStyle(color: Colors.white),
                )
              )
            ),
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 1),
      ),
    );
  }
}