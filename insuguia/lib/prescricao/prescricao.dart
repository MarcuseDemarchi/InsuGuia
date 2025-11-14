import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/prescricaoinfo.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/protocolo/protocolo.dart';

class PrescricaoPage extends StatelessWidget{
  const PrescricaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(25, 118, 210, 1))
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Text('Prescrições', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.blue[700],),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            SizedBox(height: 20),
            PrescricaoInfo(
              prescricao: Prescricao(
                id: 1, 
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
                  dataEmissao: DateTime(2025,11,13)  
                ), 
                dataEmissao: DateTime(2025,11,13), 
                textoPrescricao: 'Teste de prescrição'
              ),
            )
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 3),
      ),
    );
  }
}

class Prescricao {
  final int id;
  final Protocolo protocolo;
  final DateTime dataEmissao;
  final String textoPrescricao;

  Prescricao({
    required this.id,
    required this.protocolo,
    required this.dataEmissao, 
    required this.textoPrescricao
  });
}