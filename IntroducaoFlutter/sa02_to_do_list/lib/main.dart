  import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ToDoListApp(),));
  }

// janela do aplicativo
// statefulwidget
class ToDoListApp extends StatefulWidget{//1° classe realiza a mudança de estado(setState)
@override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<ToDoListApp>{//2° classe realiza o build => logica de Contrução da Janela
// atributos
final TextEditingController _tarefaController = TextEditingController();
List<Map<String, dynamic>> _tarefas = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: "Digite uma tarefa"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _adicionarTarefa, 
              child: Text("Adicionar Tarefa")
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (context, index)=>ListTile(
                    title: Text(_tarefas[index]["titulo"], style: TextStyle(
                      decoration: _tarefas[index]["concluida"] ? TextDecoration.lineThrough : null //operador ternário
                    ),),
                    leading: Checkbox(value: _tarefas[index]["concluida"],
                    onChanged: (bool? valor)=> setState(() {
                      _tarefas[index]["concluida"] = valor!;
                    })),
                  ))
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _removerTarefasConcluidas,
        backgroundColor: Colors.red,
        child: Text("Remover"),
        ),
    );
  }


  void _adicionarTarefa() {
    if(_tarefaController.text.trim().isNotEmpty){
      setState(() {
        _tarefas.add({"titulo":_tarefaController.text,"concluida":false});
        _tarefaController.clear();
      });
    }
  }

  void _removerTarefasConcluidas() {
    setState(() {
      _tarefas.removeWhere((tarefa)=>tarefa["concluida"]);
    });
  }
}