import 'package:ejercicio_semana4_clase1/pages/pagina2.dart';
import 'package:flutter/material.dart';

class EjemploNav extends StatelessWidget {
  const EjemploNav({super.key});

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
          child: Text('Ir a página 2'),
          onPressed: () {
            //Crear ruta
            MaterialPageRoute rutaPagina2 = MaterialPageRoute(
              builder: (context) => Pagina2(),
            );
            //Navegar a ruta
            Navigator.push(context, rutaPagina2);
          },
        ),
      ),
    );
  }
}
