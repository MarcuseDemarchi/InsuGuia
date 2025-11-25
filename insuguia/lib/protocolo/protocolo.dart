import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/listaprotocolos.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/paciente/pacienteselect.dart';

class ProtocoloPage extends StatelessWidget{
  const ProtocoloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.blue[700],
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(
                onPressed: () => {
                    Navigator.pop(context),
                },
                icon: Icon(Icons.arrow_back), 
                color: Colors.white,
              ),
              Text('Protocolos', style: TextStyle(color: Colors.white),),
            ],
          ),  
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[700],
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteSelectPage(isProtocolo: true,)))
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),  
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Expanded(child: ListaProtocolos())
            ],
          )
        ),
        bottomNavigationBar: AppNavigationBar(index: 1),
      ),
    );
  }
}

class Protocolo {
  final int id;
  Paciente paciente;
  final String dieta;
  final String corticoide;
  final String hepatica;
  final String sensibilidade;
  final int ultimaGlicemia;
  final double escala;
  final String tipoBasal;
  final String posologia;
  final String tipoAcaoRapida;
  final int bolusPrandial;
  final DateTime dataEmissao;

  Protocolo(
    {
    required this.id,
    required this.paciente, 
    required this.dieta, 
    required this.corticoide, 
    required this.hepatica, 
    required this.sensibilidade, 
    required this.ultimaGlicemia, 
    required this.escala, 
    required this.tipoBasal, 
    required this.posologia, 
    required this.tipoAcaoRapida, 
    required this.bolusPrandial,
    required this.dataEmissao
    }
  );


  factory Protocolo.fromJson(json){
    return Protocolo(
      id            : json['procodigo'],
      paciente      : Paciente.fromJson(json['paciente']), 
      dieta         : json['prodieta'],
      corticoide    : json['protipocorticosteroide'], 
      hepatica      : json['prodoencahepatica'] ? 'Não' : 'Sim',
      sensibilidade : json['prosensibilidadeinsu'],
      ultimaGlicemia: json['proglicemiaatual'], 
      escala        : json['proescaladispositivo'],
      tipoBasal     : json['protipoinsubasal'], 
      posologia     : json['proposologiabasal'], 
      tipoAcaoRapida: json['proinsuacaorapida'], 
      bolusPrandial : json['probolusprandial'], 
      dataEmissao   : DateTime.parse(json['prodataemissao']),
    );
  }
}