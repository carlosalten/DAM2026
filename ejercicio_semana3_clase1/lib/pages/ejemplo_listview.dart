import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EjemploListview extends StatelessWidget {
  const EjemploListview({super.key});

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
        padding: EdgeInsetsGeometry.all(5),
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
                    title: Text('Lenovo P3 Thinkstation'),
                    subtitle: Text('Computador lab U140'),
                    leading: Icon(Icons.computer),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Apple Macbook Pro'),
                    subtitle: Text('Equipo para desarrollo iOS'),
                    leading: Icon(Icons.computer),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('GMKtec N150'),
                    subtitle: Text('Home Server'),
                    leading: Icon(Icons.computer),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
