import 'package:ejercicio_semana04_clase1/pages/pagina2.dart';
import 'package:flutter/material.dart';

class EjemploNav1 extends StatelessWidget {
  const EjemploNav1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Ejemplo MaterialPageRoute'),
      ),
      body: Center(
        child: FilledButton(
          child: Text('Navegar a Página 2'),
          onPressed: () {
            // construir ruta
            MaterialPageRoute rutaPagina2 = MaterialPageRoute(
              builder: (context) => Pagina2(),
            );
            // Navegar hacia la ruta
            Navigator.push(context, rutaPagina2);
          },
        ),
      ),
    );
  }
}
