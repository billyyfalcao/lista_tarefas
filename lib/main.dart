import 'package:flutter/material.dart';
import 'segunda_pagina.dart';

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
  List<String> tarefas = [];

  final TextEditingController tarefaController = TextEditingController();

  int? indiceEditando;

  void AdicionaTarefa() {
    if (tarefaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Tarefa vazia, insira uma tarefa antes de adicionar!",
          ),
        ),
      );

      return;
    }

    setState(() {
      if (indiceEditando == null) {
        tarefas.add(tarefaController.text);
      } else {
        tarefas[indiceEditando!] = tarefaController.text;
        indiceEditando = null;
      }
    });

    tarefaController.clear();
  }

  void RemoverTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);

      if (indiceEditando == index) {
        indiceEditando = null;
        tarefaController.clear();
      } else if (indiceEditando != null && indiceEditando! > index) {
        indiceEditando = indiceEditando! - 1;
      }
    });
  }

  void editarTarefa(int index) {
    setState(() {
      indiceEditando = index;
      tarefaController.text = tarefas[index];
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
                      title: Text(tarefas[index]),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              editarTarefa(index);
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              RemoverTarefa(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12.0),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Ir para outra página'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SegundaPagina(),
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
