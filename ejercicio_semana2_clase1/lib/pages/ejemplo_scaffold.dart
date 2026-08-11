import 'package:flutter/material.dart';

class EjemploScaffold extends StatelessWidget {
  const EjemploScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        title: Text("Ejemplo Scaffold"),
        centerTitle: true,
        leading: Icon(Icons.android, size: 40),
      ),
      body: Center(
        child: Text(
          'Ejemplo de Scaffold',
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
