import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/protocoloinfo.dart';
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
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.blue[700],),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                
              ),
            ),
            SizedBox(height: 10,),
            ProtocoloInfo(
              protocolo: Protocolo(
                id: 1,
                paciente: Paciente(
                nomePaciente: 'Paciente Teste', 
                sexo: 'Masculino', 
                idade: 28, 
                peso: 70, 
                altura: 165, 
                creatinina: 0.8, 
                localInternacao: 'Enfermaria'),
                dieta: 'oral_boa',
                corticoide: 'nao', 
                hepatica: 'nao', 
                sensibilidade: 'media', 
                ultimaGlicemia: 220, 
                escala: 1, 
                tipoBasal: 'nph', 
                posologia: '3_manha_almoco_noite', 
                tipoAcaoRapida: 'regular', 
                bolusPrandial: 100,
                dataEmissao: DateTime(2025,11,13))
            ),
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 1),
      ),
    );
  }
}

class Protocolo {
  final int id;
  final Paciente paciente;
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

  const Protocolo(
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
}