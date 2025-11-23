import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/paciente.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PacienteEditarPage extends StatelessWidget{
  final Paciente paciente;

  PacienteEditarPage({
    super.key,
    required this.paciente,
  });


  late final TextEditingController controllerNome = TextEditingController(text: paciente.nomePaciente);
  late final TextEditingController controllerIdade = TextEditingController(text: paciente.idade.toString());
  final TextEditingController controllerSexo = TextEditingController();
  late final TextEditingController controllerCreatinina = TextEditingController(text: paciente.creatinina.toString());
  late final TextEditingController controllerPeso = TextEditingController(text: paciente.peso.toString());
  late final TextEditingController controllerAltura = TextEditingController(text: paciente.altura.toString());
  final TextEditingController controllerLocalInternacao = TextEditingController();
  final TextEditingController controllerClassificacao = TextEditingController();

  Future<void> updatePaciente(BuildContext context, int paccodigo) async{
     final Paciente pacienteEditar;
     
     try{
      pacienteEditar = Paciente(
      id: 0,
      nomePaciente: controllerNome.text, 
      sexo: controllerSexo.text, 
      idade: int.parse(controllerIdade.text), 
      peso: double.parse(controllerPeso.text), 
      altura: double.parse(controllerAltura.text), 
      creatinina: double.parse(controllerCreatinina.text), 
      localInternacao: controllerLocalInternacao.text
      );
    }
    catch (exeption){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Erro Ao Atualizar Paciente'),
          content: Text('Por favor preencha todos os campos solicitados.'),
          actions: [
            TextButton(
              onPressed: () =>{ 
                Navigator.pop(context)
              },  
              child: Text('Ok', style: TextStyle(color: Colors.blue[700]),),
            ),
          ],
        ));   

      return;
    }
    
    
    var response = await http.put(
      Uri.parse('http://127.0.0.1:5000/updatePaciente/${paccodigo}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
         body: jsonEncode(<String, dynamic>{    
        "paciente_nome" : pacienteEditar.nomePaciente,
        "paciente_sexo" : pacienteEditar.sexo,
        "paciente_idade" : pacienteEditar.idade,
        "paciente_peso" : pacienteEditar.peso,
        "paciente_altura" : pacienteEditar.altura,
        "paciente_creatinina" : pacienteEditar.creatinina,
        "paciente_imc" : pacienteEditar.calculaIMC(),
        "paciente_tfg" : pacienteEditar.calculaTFG(),
        "paciente_localinternacao" : pacienteEditar.localInternacao,
        }),
      );

    dynamic responseJson = jsonDecode(response.body);

    if (responseJson['code'] == 200){
      Navigator.pop(context);
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Cadastro de Paciente'),
          content: Text('Paciente Atualizado com sucesso!'),
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
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Cadastro de Paciente'),
          content: Text(responseJson['message']),
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
  }

  Future<void> deletePaciente(BuildContext context, int paccodigo) async{
    var response = await http.delete(
      Uri.parse('http://127.0.0.1:5000/deletePaciente/${paccodigo}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

    dynamic responseJson = jsonDecode(response.body);

    if (responseJson['code'] == 204){
      Navigator.pop(context);
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Cadastro de Paciente'),
          content: Text('Paciente Deletado com sucesso!'),
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
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Cadastro de Paciente'),
          content: Text(responseJson['message']),
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
              Text('Editar Paciente', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: ListView(
            children: [
              TextField(
                controller: controllerNome,
                decoration: InputDecoration(
                  label: Text('Nome Completo', style: TextStyle(color: Colors.blue[700]),),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: controllerIdade,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Idade', style: TextStyle(color: Colors.blue[700]),),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 7,
                    child: DropdownMenu(
                      width: double.infinity,
                      enableFilter: true,
                      controller: controllerSexo,
                      initialSelection: paciente.sexo,
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
                  controller: controllerCreatinina,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    label: Text('Creatinina (ml/dL)', style: TextStyle(color: Colors.blue[700]),),
                  ),
                )
              ),
              const SizedBox(height: 20),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controllerPeso,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        label: Text('Peso (Kg)', style: TextStyle(color: Colors.blue[700]),),
                      ),
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: controllerAltura,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Altura (cm)', style: TextStyle(color: Colors.blue[700]),),
                      ),
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
                  initialSelection: paciente.localInternacao,
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
                  initialSelection: 'Não Crítico',
                  label: Text('Classificação Clínica', style: TextStyle(color: Colors.blue[700])),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'Não Crítico', label: 'Não crítico (Diabetes mellitus prévio/Hiperglicemia hospitalar)')
                  ]                    
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 20,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                      ),
                      onPressed: (){
                        updatePaciente(context, paciente.id);
                      }, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(Icons.save, color: Colors.white,),
                          Text('Salvar', style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                      ),
                      onPressed: () => showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title: Text('Excluir Paciente?'),
                          content: Text('Deseja realmente excluir o paciente selecionado?'),
                          actions: [
                            TextButton.icon(
                              onPressed: () =>{ 
                                Navigator.pop(context)
                              }, 
                              label: Text('Cancelar'),
                              icon: Icon(Icons.arrow_back),
                            ),
                            TextButton.icon(
                              onPressed: () =>{ 
                                deletePaciente(context, paciente.id),
                              }, 
                              label: Text('Excluir', style: TextStyle(color: Colors.red),),
                              icon: Icon(Icons.delete, color: Colors.red,),
                            ),
                          ],
                        )), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          Text('Excluir', style: TextStyle(color: Colors.red)),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppNavigationBar(index: 0),
      ),
    );
  }
}