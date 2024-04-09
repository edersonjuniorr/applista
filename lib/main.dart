import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Tarefa {
  String title;

  Tarefa(this.title);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebApp Tarefas',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFCEAA0D, <int, Color>{
          50: Color(0xFFFFF8E1),
          100: Color(0xFFFFECB3),
          200: Color(0xFFFFE082),
          300: Color(0xFFFFD54F),
          400: Color(0xFFFFCA28),
          500: Color(0xFFFFC107),
          600: Color(0xFFFFB300),
          700: Color(0xFFFFA000),
          800: Color(0xFFFF8F00),
          900: Color(0xFFFF6F00),
        }),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ListaTarefa(),
        '/tarefa': (context) => AddTarefa(),
      },
    );
  }
}


class ListaTarefa extends StatefulWidget {
  @override
  _ListaTarefaState createState() => _ListaTarefaState();
}

class _ListaTarefaState extends State<ListaTarefa> {
  List<Tarefa> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Afazeres'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index].title),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 0.0),
            ),
            child: ListTile(
              title: Text(tasks[index].title),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tarefa').then((outputTarefa) {
            if (outputTarefa != null && outputTarefa is Tarefa) {
              setState(() {
                tasks.add(outputTarefa);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTarefa extends StatelessWidget {
  final TextEditingController tituloTarefa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Título da tarefa'),
            TextField(
              controller: tituloTarefa,
              decoration: InputDecoration(
                labelText: 'Digite o nome da tarefa',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (tituloTarefa.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Tarefa(tituloTarefa.text),
                  );
                }
              },
              child: Text('Concluído'),
            ),
          ],
        ),
      ),
    );
  }
}
