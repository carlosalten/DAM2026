import 'package:flutter/material.dart';

class Pagina2 extends StatelessWidget {
  const Pagina2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text('Página 2'),
      ),
      body: Center(
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red.shade800,
            foregroundColor: Colors.white,
          ),
          child: Text('Volver'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
