import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TarefaProvider(),
      child: MyApp(),
    ),
  );
}

class Tarefa {
  String title;

  Tarefa(this.title);
}

class TarefaProvider extends ChangeNotifier {
  List<Tarefa> _tasks = [];

  List<Tarefa> get tasks => _tasks;

  void addTarefa(Tarefa tarefa) {
    _tasks.add(tarefa);
    notifyListeners();
  }

  void removeTarefa(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
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

class ListaTarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tarefaProvider = Provider.of<TarefaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Afazeres'),
      ),
      body: ListView.builder(
        itemCount: tarefaProvider.tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tarefaProvider.tasks[index].title),
            onDismissed: (direction) {
              tarefaProvider.removeTarefa(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 0.0),
            ),
            child: ListTile(
              title: Text(tarefaProvider.tasks[index].title),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTarefa()),
          );
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
    var tarefaProvider = Provider.of<TarefaProvider>(context);

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
                  tarefaProvider.addTarefa(Tarefa(tituloTarefa.text));
                  Navigator.pop(context); // Corrigido aqui
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
