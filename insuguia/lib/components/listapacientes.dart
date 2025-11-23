import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:insuguia/components/pacienteinfo.dart';
import 'package:insuguia/components/pacienteselectContainer.dart';
import 'package:insuguia/paciente/paciente.dart';

class ListaPacientes extends StatefulWidget {
  const ListaPacientes({super.key, required this.select, required this.selectToProtocol});

  final bool select;
  final bool selectToProtocol; 

  @override
  State<ListaPacientes> createState() => _ListaPacientesState();
}

class _ListaPacientesState extends State<ListaPacientes>{
  Future<List<Paciente>> pacientesFuture = getPacientes();  

  static Future<List<Paciente>> getPacientes() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/getPacientes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Paciente.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
  
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: pacientesFuture, 
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      }
      else if (snapshot.hasError){
        return Text('${snapshot.error}');
      }
      else if (snapshot.hasData) {
        final pacientes = snapshot.data;
        return buildLista(pacientes);
      }
      else{
        return Text('Sem dados para serem mostrados');
      }
    }, 
  );

  Widget buildLista(List<Paciente> lista) => ListView.builder(
    itemCount: lista.length,
    itemBuilder: (context, index) {
      final paciente = lista[index]; 

      if (widget.select) {
        return PacienteSelectContainer(paciente: paciente, selectToProtocol: widget.selectToProtocol);
      }
      else{
        return PacienteInfo(paciente: paciente);
      }
    },

  );
}