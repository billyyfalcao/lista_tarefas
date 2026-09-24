import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'segunda_pagina.dart';
import 'database/database_helper.dart';

void main() {
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

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
  List<Map<String, dynamic>> tarefas = [];

  final TextEditingController tarefaController = TextEditingController();

  int? indiceEditando;

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    final dados = await DatabaseHelper.instance.listarTarefas();

    setState(() {
      tarefas = dados;
    });
  }

  Future<void> adicionaTarefa() async {
    if (tarefaController.text.isEmpty) {

      return;
    }

      await DatabaseHelper.instance.inserirTarefa(tarefaController.text);
      tarefaController.clear();

      _carregarTarefas();
  }

  Future<void> removerTarefa(int index) async {
    
    await DatabaseHelper.instance.removerTarefa(index);
    _carregarTarefas();
  }

//  void editarTarefa(int index) {
//    setState(() {
//      indiceEditando = index;
//      tarefaController.text = tarefas[index];
//    });
//  }

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
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 8.0),

                ElevatedButton(
                  onPressed: adicionaTarefa,
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
                      title: Text(
                        tarefas[index]['descricao'],
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),

                            onPressed: () {
                              //editarTarefa(index);
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),

                            onPressed: () {
                              removerTarefa(tarefas[index]['id']);
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

                label: const Text(
                  'Ir para outra página',
                ),

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
