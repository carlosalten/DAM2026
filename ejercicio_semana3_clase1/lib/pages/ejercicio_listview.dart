import 'package:flutter/material.dart';

class EjercicioListview extends StatelessWidget {
  const EjercicioListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
        title: Text('Ejemplo Listview'),
        leading: Icon(Icons.list),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.lightBlue.shade200,
              alignment: Alignment.center,
              child: Text('Lista de productos', style: TextStyle(fontSize: 26)),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Apple Macbook Pro'),
                    subtitle: Text('Equipo para desarrollo iOS'),
                    leading: Icon(Icons.computer),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Lenovo P3 ThinkStation'),
                    subtitle: Text('Laboratorio U140'),
                    leading: Icon(Icons.computer),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('CMKtec N150'),
                    subtitle: Text('Mini PC'),
                    leading: Icon(Icons.computer),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
