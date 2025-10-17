import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Text(
            'Boas-vindas',
            style: TextStyle(color:Colors.white),
          ),
        ),
        backgroundColor:Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 247, 230, 1),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(251, 140, 0, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Aviso importante: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'As doses são ', 
                        ),
                        TextSpan(
                          text: 'sugestões ',
                          style: TextStyle(fontWeight: FontWeight.bold) 
                        ),
                        TextSpan(
                          text: 'baseadas nas Diretrizes da '
                        ),
                        TextSpan(
                          text: 'Sociedade Brasileira de Diabetes (SBD). ',
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: 'A prescrição final é de ' 
                        ),
                        TextSpan(
                          text: 'responsabilidade do médico',
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: ', considerando o contexto clínico e protocolos institucionais.'
                        )
                      ]
                    )
                  ),
                )
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(20,0,20,20),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'As Diretrizes recomendam glicemia capilar na admissão de '
                    ),
                    TextSpan(
                      text: 'todos ',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: 'os pacientes. Considera-se '
                    ),
                    TextSpan(
                      text: 'Hiperglicemia Hospitalar (HH)',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: 'quando a glicemia (capilar ou plasmática) está > '
                    ),
                    TextSpan(
                      text: '140 mg/dL.',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    )
                  ]
                )
              ),
            ),
            Container(
              padding: EdgeInsetsGeometry.fromLTRB(20,0,20,20),
              alignment: Alignment.topLeft,
              child: Text(
                'Fluxo',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AppNavigationBar(index: 2),
              ),
            ),
          ],
        )
      ),
    );
  }
}