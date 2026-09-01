import 'package:ejercicio7/data/locales.dart';
import 'package:ejercicio7/widgets/local_card.dart';
import 'package:flutter/material.dart';

class TabLocales extends StatelessWidget {
  const TabLocales({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            'Nuestros Locales',
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: locales.length,
            itemBuilder: (context, index) {
              return LocalCard(
                nombre: locales[index]['nombre'],
                direccion: locales[index]['direccion'],
                imagen: locales[index]['imagen'],
              );
            },
          ),
        ),
        // LocalCard(
        //   nombre: 'Valparaíso',
        //   direccion: '8810 Bayside Court',
        //   imagen: 'valparaiso.jpg',
        // ),
      ],
    );
  }
}
