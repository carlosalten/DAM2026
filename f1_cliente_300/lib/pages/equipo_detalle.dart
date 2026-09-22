import 'package:f1_cliente_300/constants.dart';
import 'package:f1_cliente_300/services/f1_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class EquipoDetalle extends StatelessWidget {
  const EquipoDetalle({
    super.key,
    required this.equipoId,
    this.colorEquipo = kPrimaryColor,
  });

  final int equipoId;
  final Color colorEquipo;

  @override
  Widget build(BuildContext context) {
    String titulo = 'Cargando...';
    Widget body = Center(child: CircularProgressIndicator());

    return FutureBuilder(
      future: F1Service().equipo(equipoId),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          titulo = 'Error :(';
          body = Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData &&
            snapshot.connectionState != ConnectionState.waiting) {
          var equipo = snapshot.data;
          titulo = equipo['nombre'];
          body = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipo['nombre'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Divider(color: colorEquipo, thickness: 4),
                Row(
                  children: [
                    Text('Jefe de equipo: '),
                    Text(
                      equipo['jefe'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Text(
                    'PILOTOS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: equipo['pilotos'].length,
                    itemBuilder: (context, index) {
                      var piloto = equipo['pilotos'][index];
                      return ListTile(
                        leading: Icon(
                          MdiIcons.racingHelmet,
                          size: 26,
                          color: colorEquipo,
                        ),
                        title: Row(
                          children: [
                            Text('${piloto['nombre']} '),
                            Text(
                              piloto['apellido'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorEquipo, kSecondaryColor],
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titulo),
                SizedBox(
                  width: 50,
                  child: Image.asset('assets/images/logo_f1.png'),
                ),
              ],
            ),
          ),
          body: body,
        );
      },
    );
  }
}
