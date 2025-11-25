import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/paciente.dart';
import 'package:insuguia/paciente/pacientedetails.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/prescricao/prescricaodetails.dart';
import 'package:flutter/services.dart'; // Import this for Clipboard

class AcompanhamentoResultsPage extends StatelessWidget{
  const AcompanhamentoResultsPage({super.key, required this.paciente, required this.ajustes, required this.prescricao});

  final Paciente paciente;
  final Prescricao prescricao;
  final String ajustes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor: const Color.fromRGBO(25, 118, 210, 1)) 
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(onPressed:() {
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.arrow_back, color: Colors.white,)),
              Text('Sugestões', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  side: BorderSide(color: Colors.black38)
                )
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteDetailsPage(paciente: paciente)));
              }, 
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Icon(Icons.personal_injury, color: Colors.blue[700], size: 36,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                        Text("${paciente.idade} Anos | ${paciente.sexo}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  side: BorderSide(color: Colors.black38)
                )
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrescricaoDetailsPage(prescricao: prescricao)));
              }, 
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.medication_rounded, color: Colors.blue[700], size: 36,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prescrição #${prescricao.id}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                        Text("${prescricao.dataEmissao.day}/${prescricao.dataEmissao.month}/${prescricao.dataEmissao.year}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black38)),
                label: Text('Ajustes sugeridos', style: TextStyle(color: Colors.blue[700]),)
              ),              
            child: Text(ajustes)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(5),
                      )
                    ),
                    onPressed: () async{
                      await Clipboard.setData(ClipboardData(text: ajustes));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copiado!')),
                      );
                    }, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.copy, color: Colors.white,),
                        Text('Copiar', style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ), 
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(5),
                        side: BorderSide(color: const Color.fromRGBO(25, 118, 210, 1))
                      )
                    ),
                    onPressed: () {

                    }, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.picture_as_pdf_outlined, color: Colors.blue[700],),
                        Text('Exportar (PDF)', style: TextStyle(color: Colors.blue[700]),)
                      ],
                    )
                  ), 
                ),
              ],
            )
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: AppNavigationBar(index: 4),
      ),
    );
  }
}