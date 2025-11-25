import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:insuguia/protocolo/protocolo.dart';
import 'package:insuguia/components/protocoloinfo.dart';

class ListaProtocolos extends StatefulWidget {
  const ListaProtocolos({super.key});

  @override
  State<ListaProtocolos> createState() => _ListaProtocolostate();
}

class _ListaProtocolostate extends State<ListaProtocolos>{
  Future<List<Protocolo>> protocolosFuture = getProtocolos();  

  static Future<List<Protocolo>> getProtocolos() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/getProtocolo'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Protocolo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
  
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: protocolosFuture, 
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      }
      else if (snapshot.hasError){
        return Text('${snapshot.error}');
      }
      else if (snapshot.hasData) {
        final protocolos = snapshot.data;
        return buildLista(protocolos);
      }
      else{
        return Text('Sem dados para serem mostrados');
      }
    }, 
  );

  Widget buildLista(List<Protocolo> lista) => ListView.builder(
    itemCount: lista.length,
    itemBuilder: (context, index) {
      final protocolo = lista[index]; 

      return ProtocoloInfo(protocolo: protocolo);
    },
  );
}