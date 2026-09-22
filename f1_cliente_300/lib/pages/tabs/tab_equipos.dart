import 'package:f1_cliente_300/pages/equipo_detalle.dart';
import 'package:f1_cliente_300/services/f1_service.dart';
import 'package:f1_cliente_300/utils/color_desde_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

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
            Color colorEquipo = colorDesdeHex(equipo['color']);
            return ListTile(
              leading: Icon(MdiIcons.carSports, size: 30, color: colorEquipo),
              title: Text('${equipo['nombre']} (${equipo['pais']})'),
              subtitle: Text('Jefe de equipo: ${equipo['jefe']}'),
              onTap: () {
                // print('EquipoId: ${equipo['id']}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipoDetalle(
                      equipoId: equipo['id'],
                      colorEquipo: colorEquipo,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
