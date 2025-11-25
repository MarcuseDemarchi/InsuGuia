import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/listaprescricao.dart';
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
        body: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Expanded(child: ListaPrescricoes())
            ],
          )
        ),
        bottomNavigationBar: AppNavigationBar(index: 3),
      ),
    );
  }
}

class Prescricao {
  final int id;
  final int paccodigo;
  final Protocolo protocolo;
  final DateTime dataEmissao;
  final String conteudo;

  Prescricao({
    required this.id,
    required this.paccodigo,
    required this.protocolo,
    required this.conteudo, 
    required this.dataEmissao,
  });


  factory Prescricao.fromJson(json){
    return Prescricao(
      id: json['precodigo'], 
      paccodigo: json['paccodigo'],
      protocolo: Protocolo.fromJson(json['protocolo']), 
      conteudo: json['preconteudo'], 
      dataEmissao: DateTime.parse(json['datacriacao']),
    );
  }
}