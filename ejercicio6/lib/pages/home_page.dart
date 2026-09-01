import 'package:ejercicio6/data/juegos.dart';
import 'package:ejercicio6/widgets/juego_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          MdiIcons.gamepadSquare,
          color: Colors.deepOrange,
          size: 40,
        ),
        title: Row(
          children: [
            Text('La tiendita ', style: TextStyle(color: Colors.blue)),
            Text(
              'USM',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.orange,
                border: Border.all(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Catálogo de Juegos ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Icon(MdiIcons.gamepadVariant, color: Colors.white, size: 30),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: juegos.length,
                itemBuilder: (context, index) {
                  return JuegoCard(
                    titulo: juegos[index]['titulo'],
                    imagen: juegos[index]['imagen'],
                    precio: juegos[index]['precio'],
                  );
                },
              ),
              // child: ListView(
              //   children: [
              //     JuegoCard(
              //       titulo: 'Super Mario Kart 8 Deluxe',
              //       imagen: 'mario_kart_8_deluxe.jpg',
              //       precio: '55.000',
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
