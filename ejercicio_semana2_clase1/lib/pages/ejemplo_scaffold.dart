import 'package:flutter/material.dart';

class EjemploScaffold extends StatelessWidget {
  const EjemploScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        title: Text('Ejemplo Scaffold'),
        centerTitle: true,
        leading: Icon(Icons.android, size: 30),
      ),
      body: Center(
        child: Text(
          'Ejemplo de Scaffold',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
