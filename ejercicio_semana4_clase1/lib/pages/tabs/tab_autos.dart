import 'package:flutter/material.dart';

class TabAutos extends StatelessWidget {
  const TabAutos({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Autos',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
