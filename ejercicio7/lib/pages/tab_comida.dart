import 'package:ejercicio7/data/productos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class TabComida extends StatelessWidget {
  const TabComida({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: productos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(
              'assets/images/comida/${productos[index]["imagen"]}',
            ),
          ),
          title: Text(
            productos[index]['nombre'],
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(productos[index]['descripcion']),
          trailing: Container(
            child: Column(
              children: [
                Icon(MdiIcons.plusBox, color: Colors.blue, size: 30),
                Text(
                  '\$${productos[index]['precio']}',
                  style: TextStyle(fontSize: 14, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
