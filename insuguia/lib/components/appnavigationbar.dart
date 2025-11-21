import 'package:flutter/material.dart';
import 'package:insuguia/acompanhamento/acompanhamento.dart';
import 'package:insuguia/home.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/protocolo/protocolo.dart';

class AppNavigationBar extends StatelessWidget{
  // const AppNavigationBar({super.key});
  final int index;
  final List<Widget> paginas = [
    PacientePage(),
    ProtocoloPage(),
    HomePage(),
    PrescricaoPage(),
    AcompanhamentoPage(),
  ];

  AppNavigationBar({
    super.key,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    
    return BottomNavigationBar(
      backgroundColor: Colors.blue[700],
      currentIndex: index,
      iconSize: 30,
      onTap: (value) => {
        if (value != index) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => paginas[value]))
        } 
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.personal_injury), 
          label: 'Paciente',
          backgroundColor: Colors.blue[700]),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_information), 
          label: 'Protocolo',
          backgroundColor: Colors.blue[700]),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.blue[700]),
        BottomNavigationBarItem(
          icon: Icon(Icons.medication), 
          label: 'Prescrição',
          backgroundColor: Colors.blue[700]),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined), 
          label: 'Acompanhamento',
          backgroundColor: Colors.blue[700]),
    ]);
  }
}