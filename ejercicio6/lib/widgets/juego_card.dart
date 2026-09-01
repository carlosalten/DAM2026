import 'package:flutter/material.dart';

class JuegoCard extends StatelessWidget {
  const JuegoCard({
    super.key,
    required this.titulo,
    required this.imagen,
    required this.precio,
  });

  final String titulo, imagen, precio;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset('assets/images/$imagen'),
          Text(
            titulo,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Precio: \$$precio',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Comprar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
