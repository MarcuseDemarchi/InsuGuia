import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/pacientedetails.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/protocolo/protocolo.dart';

class Protocolodetails extends StatelessWidget{
  final Protocolo protocolo;

  const Protocolodetails({
    super.key,
    required this.protocolo
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(25, 118, 210, 1)),
        dropdownMenuTheme: DropdownMenuThemeData(
          disabledColor: Colors.black,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(
                onPressed: () => {
                  Navigator.pop(context)
                }, 
                icon: Icon(Icons.arrow_back, color: Colors.white)
              ),
              Text('Detalhes do Protocolo', style: TextStyle(color: Colors.white))
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteDetailsPage(paciente: protocolo.paciente)));
              }, 
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Icon(Icons.personal_injury, color: Colors.blue[700], size: 36,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(protocolo.paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                        Text("${protocolo.paciente.idade} Anos | ${protocolo.paciente.sexo}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    label: Text('Dieta', style: TextStyle(color: Colors.blue[700])),
                    initialSelection: protocolo.dieta,      
                    controller: TextEditingController(text: protocolo.dieta),
                    enabled: false,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 'oral_boa', label: 'Oral - Boa aceitação'),
                      DropdownMenuEntry(value: 'oral_mal', label: 'Oral - Má aceitação'),
                      DropdownMenuEntry(value: 'enteral', label: 'Enteral'),
                      DropdownMenuEntry(value: 'parenteral', label: 'Parenteral'),
                      DropdownMenuEntry(value: 'npo', label: 'NPO'),
                    ],       
                    inputDecorationTheme: InputDecorationTheme(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54)
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownMenu(
                    width: double.infinity,
                    enableFilter: true,
                    initialSelection: protocolo.corticoide,
                    controller: TextEditingController(text: protocolo.corticoide),
                    enabled: false,
                    label: Text('Uso de Corticoide', style: TextStyle(color: Colors.blue[700])),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 'nao', label: 'Não'),
                      DropdownMenuEntry(value: 'prednisona_baixa', label: 'Prednisona Baixa'),
                      DropdownMenuEntry(value: 'prednisona_media', label: 'Prednisona Média'),
                      DropdownMenuEntry(value: 'alta', label: 'Prednisona Alta'),
                    ],       
                    inputDecorationTheme: InputDecorationTheme(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54)
                      ),
                    ),                    
                  ),
                  SizedBox(height: 20),
                  DropdownMenu(
                    width: double.infinity,
                    enableFilter: true,
                    enabled: false,
                    initialSelection: protocolo.hepatica,
                    controller: TextEditingController(text: protocolo.hepatica),
                    label: Text('Doença Hepática', style: TextStyle(color: Colors.blue[700])),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 'nao', label: 'Não'),
                      DropdownMenuEntry(value: 'sim', label: 'Sim'),
                    ],       
                    inputDecorationTheme: InputDecorationTheme(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54)
                      ),
                    ),                    
                  ),
                  SizedBox(height: 20),
                  DropdownMenu(
                    width: double.infinity,
                    enableFilter: true,
                    enabled: false,
                    initialSelection: protocolo.sensibilidade,
                    controller: TextEditingController(text: protocolo.sensibilidade),
                    label: Text('Sensibilidade a insulina', style: TextStyle(color: Colors.blue[700])),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 'baixa', label: 'Sensível'),
                      DropdownMenuEntry(value: 'media', label: 'Usual'),
                      DropdownMenuEntry(value: 'alta', label: 'Resistente'),
                    ],       
                    inputDecorationTheme: InputDecorationTheme(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54)
                      ),
                    ),                    
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    controller: TextEditingController(text: "${protocolo.ultimaGlicemia} mg/dL"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
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
                    initialSelection: protocolo.escala,
                    controller: TextEditingController(text: "${protocolo.escala} UI"),
                    enabled: false,
                    label: Text('Escala (UI) do dispositivo', style: TextStyle(color: Colors.blue[700])),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 0.5, label: '0.5 UI'),
                      DropdownMenuEntry(value: 1, label: '1 UI'),
                      DropdownMenuEntry(value: 2, label: '2 UI'),
                    ],    
                    inputDecorationTheme: InputDecorationTheme(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54)
                      ),
                    ),
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
                            initialSelection: protocolo.tipoBasal,
                            controller: TextEditingController(text: protocolo.tipoBasal),
                            enabled: false,
                            label: Text('Tipo', style: TextStyle(color: Colors.blue[700])),
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: 'nph', label: 'NPH'),
                              DropdownMenuEntry(value: 'glargina', label: 'Glargina'),
                              DropdownMenuEntry(value: 'degludeca', label: 'Degludeca'),
                            ],       
                            inputDecorationTheme: InputDecorationTheme(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.black54)
                              ),
                            ),                    
                          ),  
                          SizedBox(height: 20),
                          DropdownMenu(
                            width: double.infinity,
                            enableFilter: true,
                            initialSelection: protocolo.posologia,
                            controller: TextEditingController(text: protocolo.posologia),
                            enabled: false,
                            label: Text('Posologia', style: TextStyle(color: Colors.blue[700])),
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: '1_manha', label: '1 Dose - 06h'),
                              DropdownMenuEntry(value: '1_noite', label: '1 Dose - 22h'),
                              DropdownMenuEntry(value: '2_manha_almoco', label: '2 Doses - 06h e 11h'),
                              DropdownMenuEntry(value: '2_manha_noite', label: '2 Doses - 06h e 22h'),
                              DropdownMenuEntry(value: '3_manha_almoco_noite', label: '3 Doses - 06h, 11h e 22h'),
                            ],       
                            inputDecorationTheme: InputDecorationTheme(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.black54)
                              ),
                            ),                    
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
                            initialSelection: protocolo.tipoAcaoRapida,
                            controller: TextEditingController(text: protocolo.tipoAcaoRapida),
                            enabled: false,
                            label: Text('Tipo', style: TextStyle(color: Colors.blue[700])),
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: 'regular', label: 'Regular'),
                              DropdownMenuEntry(value: 'lispro', label: 'Lispro'),
                              DropdownMenuEntry(value: 'aspart', label: 'Aspart'),
                              DropdownMenuEntry(value: 'glulisina', label: 'Glulisina'),
                            ],       
                            inputDecorationTheme: InputDecorationTheme(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.black54)
                              ),
                            ),                    
                          ),  
                          SizedBox(height: 20),
                          DropdownMenu(
                            width: double.infinity,
                            enableFilter: true,
                            initialSelection: protocolo.bolusPrandial,
                            controller: TextEditingController(text: "${protocolo.bolusPrandial} mg/dL"),
                            enabled: false,
                            label: Text('Bolus prandial a partir de:', style: TextStyle(color: Colors.blue[700])),
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: 70, label: '70 mg/dL'),
                              DropdownMenuEntry(value: 100, label: '100 mg/dL'),
                              DropdownMenuEntry(value: 140, label: '140 mg/dL'),
                            ],       
                            inputDecorationTheme: InputDecorationTheme(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.black54)
                              ),
                            ),                    
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrescricaoPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(5))
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medication_rounded, color: Colors.white),
                          Text('Verificar Prescrição', style: TextStyle(color: Colors.white))
                        ],
                      ),  
                    )
                    
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 1),
      ),
    );
  }
}