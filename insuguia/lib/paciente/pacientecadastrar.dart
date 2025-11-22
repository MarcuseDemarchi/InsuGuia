import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:insuguia/paciente/paciente.dart';

class PacienteCadastrarPage extends StatelessWidget{
  PacienteCadastrarPage({super.key});

  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerIdade = TextEditingController();
  final TextEditingController controllerSexo = TextEditingController();
  final TextEditingController controllerCreatinina = TextEditingController();
  final TextEditingController controllerPeso = TextEditingController();
  final TextEditingController controllerAltura = TextEditingController();
  final TextEditingController controllerLocalInternacao = TextEditingController();
  final TextEditingController controllerClassificacao = TextEditingController();

  Future<void> cadastraPaciente(BuildContext context)async {
    
    final pacienteCriado = Paciente(
      nomePaciente: controllerNome.text, 
      sexo: controllerSexo.text, 
      idade: int.parse(controllerIdade.text), 
      peso: double.parse(controllerPeso.text), 
      altura: double.parse(controllerAltura.text), 
      creatinina: double.parse(controllerCreatinina.text), 
      localInternacao: controllerLocalInternacao.text
    );

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/cadPaciente'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{    
        "paciente_nome" : pacienteCriado.nomePaciente,
        "paciente_sexo" : pacienteCriado.sexo,
        "paciente_idade" : pacienteCriado.idade,
        "paciente_peso" : pacienteCriado.peso,
        "paciente_altura" : pacienteCriado.altura,
        "paciente_creatinina" : pacienteCriado.creatinina,
        "paciente_imc" : pacienteCriado.calculaIMC(),
        "paciente_tfg" : pacienteCriado.calculaTFG(),
        "paciente_localinternacao" : pacienteCriado.localInternacao,
      }),
    );

    dynamic responseJson = jsonDecode(response.body);


    if (responseJson['code'] == 201){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Cadastro de Paciente'),
          content: Text('Paciente Cadastrado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () => { 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PacientePage()))
              },  
              child: Text('Ok', style: TextStyle(color: Colors.blue[700]),),
            ),
          ],
        )); 
    }
    else{
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Erro Ao Cadastrar Paciente'),
          content: Text(responseJson['message']),
          actions: [
            TextButton(
              onPressed: () =>{ 
                Navigator.pop(context)
              },  
              child: Text('Ok', style: TextStyle(color: Colors.blue[700]),),
            ),
          ],
        )); 
    }
  }

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
                  Navigator.pop(context)
                }, 
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              Text('Cadastrar Paciente', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text('Nome Completo', style: TextStyle(color: Colors.blue[700]),),
                ),
                controller: controllerNome,
              ),
              const SizedBox(height: 20),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Idade', style: TextStyle(color: Colors.blue[700]),),
                      ),
                      controller: controllerIdade,
                    )
                  ),
                  Expanded(
                    flex: 7,
                    child: DropdownMenu(
                      width: double.infinity,
                      enableFilter: true,
                      controller: controllerSexo,
                      label: Text('Sexo', style: TextStyle(color: Colors.blue[700])),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 'Masculino', label: 'Masculino'),
                        DropdownMenuEntry(value: 'Feminino', label: 'Feminino'),
                      ]                    
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    label: Text('Creatinina (ml/dL)', style: TextStyle(color: Colors.blue[700]),),
                  ),
                  controller: controllerCreatinina,
                )
              ),
              const SizedBox(height: 20),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        label: Text('Peso (Kg)', style: TextStyle(color: Colors.blue[700]),),
                      ),
                    controller: controllerPeso,
                    )
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Altura (cm)', style: TextStyle(color: Colors.blue[700]),),
                      ),
                    controller: controllerAltura,
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: DropdownMenu(
                  width: double.infinity,
                  enableFilter: true,
                  controller: controllerLocalInternacao,
                  label: Text('Local de Internação', style: TextStyle(color: Colors.blue[700])),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'Enfermaria', label: 'Enfermaria'),
                    DropdownMenuEntry(value: 'UTI', label: 'UTI'),
                    DropdownMenuEntry(value: 'Centro Cirúrgico', label: 'Centro Cirúrgico'),
                    DropdownMenuEntry(value: 'Obstétricia', label: 'Obstétricia'),
                  ]                    
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: DropdownMenu(
                  width: double.infinity,
                  enableFilter: true,
                  controller: controllerClassificacao,
                  initialSelection: 'Não crítico (Diabetes mellitus prévio/Hiperglicemia hospitalar)',
                  label: Text('Classificação Clínica', style: TextStyle(color: Colors.blue[700])),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'Não Crítico', label: 'Não crítico (Diabetes mellitus prévio/Hiperglicemia hospitalar)')
                  ]                    
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                ),
                onPressed: () async{
                  cadastraPaciente(context);
                }, 
                child: Text('Cadastrar Paciente', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppNavigationBar(index: 0),
      ),
    );
  }
}