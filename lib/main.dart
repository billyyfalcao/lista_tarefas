import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 55, 58),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <String> tarefas= []; 

  final TextEditingController tarefaController = TextEditingController();
  
  void AdicionaTarefa (){
    if (tarefaController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:Text("Tarefa vazia, insira uma tarefa antes de adicionar!"))
      );

      return;
    }


    setState ((){
      tarefas.add(tarefaController.text);
    }
  );


    tarefaController.clear();

  } 

  void RemoverTarefa (int index) {
    setState(() {
      tarefas.removeAt(index);
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Lista de Tarefas",
          style: TextStyle(
            color: Color.fromARGB(255, 15, 14, 14),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tarefaController,
                    decoration: InputDecoration(
                      hintText: "Digite uma tarefa...",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8.0),

                ElevatedButton(
                  onPressed: () {
                    AdicionaTarefa();
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ),

            const SizedBox(height: 12.0),

            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(tarefas [index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          RemoverTarefa(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
