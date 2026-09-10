import 'package:f1_cliente_300/services/f1_service.dart';
import 'package:flutter/material.dart';

class TabEquipos extends StatelessWidget {
  const TabEquipos({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: F1Service().equipos(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var equipos = snapshot.data;
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: equipos.length,
          itemBuilder: (context, index) {
            var equipo = equipos[index];
            return ListTile(
              leading: Icon(Icons.car_crash),
              title: Text('${equipo['nombre']} (${equipo['pais']})'),
              subtitle: Text('Jefe de equipo: ${equipo['jefe']}'),
            );
          },
        );
      },
    );
  }
}
