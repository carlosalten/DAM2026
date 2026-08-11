import 'package:flutter/material.dart';

class EjemploColumnRow extends StatelessWidget {
  const EjemploColumnRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        backgroundColor: Color(0x66D51E2D),
        foregroundColor: Colors.white,
        leading: Icon(Icons.view_column),
        title: Text('Columnas y filas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.amber.shade900,
              alignment: Alignment.center,
              child: Text(
                'Container 1',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Spacer(flex: 1),
            Container(
              height: 100,
              width: 200,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                'Container 2',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Spacer(flex: 2),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.lightBlue.shade300,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.rocket_launch, size: 50),
                  Icon(Icons.account_box, size: 50),
                  Text('Hola Mundo', style: TextStyle(fontSize: 20)),
                  Icon(Icons.access_alarm, size: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
