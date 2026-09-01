import 'package:flutter/material.dart';

class LocalCard extends StatelessWidget {
  const LocalCard({
    super.key,
    required this.nombre,
    required this.direccion,
    required this.imagen,
  });

  final String nombre, direccion, imagen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      margin: EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/images/locales/$imagen'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0x88000000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nombre,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              direccion,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
