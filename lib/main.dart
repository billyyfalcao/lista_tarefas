import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lista de tarefas',
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
                Expanded (
                  child:TextField(
                    decoration: InputDecoration(
                      hintText: "Digite uma tarefa...",
                      hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)
                      )
                    ),
                  ),),
                  SizedBox(height:16.0), //etender como padronizar o botão com a barra
                  ElevatedButton(
                    onPressed: (){

                    },
                    child: Text("Adicionar"),
                  )
              ],
            )
          ],
        ),),

    );
  }
}
