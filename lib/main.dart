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
      theme:ThemeData(useMaterial3: true,
      colorSchemeSeed : Colors.deepPurple,
      scaffoldBackgroundColor: const Color.fromARGB(255, 106, 152, 175),),
      home: Scaffold(body: Center(child: Text('aprendendo flutter!'))),
    );
  }
}
