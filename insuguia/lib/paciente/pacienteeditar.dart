import 'package:flutter/material.dart';
import 'package:insuguia/components/appnavigationbar.dart';
import 'package:insuguia/paciente/paciente.dart';

class PacienteEditarPage extends StatelessWidget{
  final Paciente paciente;

  const PacienteEditarPage({
    super.key,
    required this.paciente,
  });

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
                controller: TextEditingController(text: paciente.nomePaciente),
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
                      controller: TextEditingController(text: paciente.idade.toString()),
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
                  controller: TextEditingController(text: paciente.creatinina.toString()),
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
                      controller: TextEditingController(text: paciente.peso.toString()),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        label: Text('Peso (Kg)', style: TextStyle(color: Colors.blue[700]),),
                      ),
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: paciente.altura.toString()),
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
                      onPressed: (){}, 
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
                                Navigator.pop(context)
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