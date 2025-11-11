import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/components/protocoloinfo.dart';

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
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
            ProtocoloInfo(),
          ],
        ),
        bottomNavigationBar: AppNavigationBar(index: 1),
      ),
    );
  }
}