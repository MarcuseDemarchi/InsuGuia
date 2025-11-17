import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/pacientedetails.dart';
import 'package:insuguia/prescricao/prescricao.dart';
import 'package:insuguia/protocolo/protocolodetails.dart';

class PrescricaoDetailsPage extends StatelessWidget{
  final Prescricao prescricao;

  const PrescricaoDetailsPage({
    super.key,
    required this.prescricao,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(25, 118, 210, 1))
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              IconButton(onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.arrow_back, color: Colors.white,)
              ),
              Text('Detalhes', style: TextStyle(color: Colors.white))
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
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
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        side: BorderSide(color: Colors.black38)
                      )
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Protocolodetails(protocolo: prescricao.protocolo)));
                    }, 
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.medical_information, color: Colors.blue[700], size: 36,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Protocolo #${prescricao.protocolo.id}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              Text("${prescricao.protocolo.dataEmissao.day}/${prescricao.protocolo.dataEmissao.month}/${prescricao.protocolo.dataEmissao.year}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        side: BorderSide(color: Colors.black38)
                      )
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PacienteDetailsPage(paciente: prescricao.protocolo.paciente)));
                    }, 
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.personal_injury, color: Colors.blue[700], size: 36,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(prescricao.protocolo.paciente.nomePaciente, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              Text("${prescricao.protocolo.paciente.idade} Anos | ${prescricao.protocolo.paciente.sexo}", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            InputDecorator(
              decoration: InputDecoration(
                label: Text('Prescrição'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. Dieta', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),),
                  Text(prescricao.tipoDieta),
                  SizedBox(height: 20),
                  Text('2. Monitorização', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),),
                  Text(prescricao.monitoracao),
                  SizedBox(height: 20),
                  Text('3. Insulina basal - ${prescricao.protocolo.tipoBasal}', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),),
                  Text('Basal total estimada: ${prescricao.basalTotal} UI/dia.', style: TextStyle(fontWeight: FontWeight.bold),),                  
                  Text(prescricao.divisaoBasal),
                  SizedBox(height: 20),
                  Text('4. Insulina de ação rápida - ${prescricao.protocolo.tipoAcaoRapida}', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),),
                  Text('data'),
                  SizedBox(height: 20),
                  Text('5. Cetonemia', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),),
                  Text(prescricao.cetonemia),
                  SizedBox(height: 20),
                  Text('6. Hipoglicemia — Conduta', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[100]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hipoglicemia:', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('Se glicemia capilar < 70 mg/dL —'),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '• Paciente consciente e capaz de deglutir: oferecer '
                              ),
                              TextSpan(
                                text: '30 mL de glicose 50%',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' (ou líquido açucarado).'
                              )
                            ]
                          )
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '• Inconsciente ou incapaz de deglutir: aplicar '
                              ),
                              TextSpan(
                                text: '30 mL de glicose 50% IV',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' em veia calibrosa.'
                              )
                            ]
                          )
                        ),
                        Text('• Repetir a glicemia capilar e a administração da glicose a cada 15 minutos até que a glicemia esteja > 100 mg/dL.')
                      ],
                    ),
                  )
                ],
              )
            ),
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
                    onPressed: () {

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
        bottomNavigationBar: AppNavigationBar(index: 3),
        backgroundColor: Colors.white,
      ),
    );
  }
}