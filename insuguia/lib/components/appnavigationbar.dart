import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget{
  // const AppNavigationBar({super.key});
  final int index;

  const AppNavigationBar({
    super.key,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    
    return BottomNavigationBar(
      backgroundColor: Colors.blue[700],
      currentIndex: index,
      iconSize: 30,
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
          icon: Icon(Icons.king_bed), 
          label: 'Alta',
          backgroundColor: Colors.blue[700]),
    ]);
  }
}