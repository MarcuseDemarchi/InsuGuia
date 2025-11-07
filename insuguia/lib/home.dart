import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/paciente.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.blue[700],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            children: [
              Icon(Icons.local_hospital, color: Colors.white,),
              Text(' Boas-vindas', style: TextStyle(color: Colors.white)),
            ],
          )
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 247, 230, 1),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(251, 140, 0, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        TextSpan(text: 'As doses são '),
                        TextSpan(
                          text: 'sugestões ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'baseadas nas Diretrizes da '),
                        TextSpan(
                          text: 'Sociedade Brasileira de Diabetes (SBD). ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'A prescrição final é de '),
                        TextSpan(
                          text: 'responsabilidade do médico',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              ', considerando o contexto clínico e protocolos institucionais.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'As Diretrizes recomendam glicemia capilar na admissão de ',
                    ),
                    TextSpan(
                      text: 'todos ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'os pacientes. Considera-se '),
                    TextSpan(
                      text: 'Hiperglicemia Hospitalar (HH)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'quando a glicemia (capilar ou plasmática) está > ',
                    ),
                    TextSpan(
                      text: '140 mg/dL.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                ),
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PacientePage()))
                },
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Text(
                    'Ir para o Cadastro de Pacientes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: ListBody(
                  children: [
                    Text(
                      'Fluxo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'Entrar ou registrar'),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '2.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'Cadastro do paciente'),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '3.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'Classificação (5 cenários)'),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '4.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'Protocolo específico'),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '5.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'Prescrição sugerida (blocos)'),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '6.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'Acompanhamento (opcional)'),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '7.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'Alta hospitalar'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Este protótipo implementa o cenário “Não crítico” com cálculos. Os demais cenários estão prontos para navegação/visualização.',
                style: TextStyle(color: Colors.black38),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Protótipo executável — InsuGuia © 2025 • Fluxo e textos baseados nas diretrizes da Sociedade Brasileira de Diabetes (SBD) • ',
                      style: TextStyle(color: Colors.black38),
                    ),
                    TextSpan(
                      text: 'Não utilizar como ferramenta clínica real',
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: AppNavigationBar(index: 2),
      ),
    );
  }
}
