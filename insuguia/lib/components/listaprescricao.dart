import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/components/prescricaoinfo.dart';

class ListaPrescricoes extends StatefulWidget {
  const ListaPrescricoes({super.key});

  @override
  State<ListaPrescricoes> createState() => _ListaPrescricoestate();
}

class _ListaPrescricoestate extends State<ListaPrescricoes>{
  Future<List<Prescricao>> prescricoesFuture = getPrescricoes();  

  static Future<List<Prescricao>> getPrescricoes() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/getPrescricao'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Prescricao.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
  
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: prescricoesFuture, 
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      }
      else if (snapshot.hasError){
        return Text('${snapshot.error}');
      }
      else if (snapshot.hasData) {
        final prescricoes = snapshot.data;
        return buildLista(prescricoes);
      }
      else{
        return Text('Sem dados para serem mostrados');
      }
    }, 
  );

  Widget buildLista(List<Prescricao> lista) => ListView.builder(
    itemCount: lista.length,
    itemBuilder: (context, index) {
      final prescricao = lista[index]; 

      return PrescricaoInfo(prescricao: prescricao);
    },
  );
}