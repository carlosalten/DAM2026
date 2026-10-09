import 'package:f1_cliente/constants.dart';
import 'package:f1_cliente/services/f1_service.dart';
import 'package:f1_cliente/utils/color_desde_hex.dart';
import 'package:flutter/material.dart';

class TabPilotos extends StatefulWidget {
  const TabPilotos({super.key});

  @override
  State<TabPilotos> createState() => _TabPilotosState();
}

class _TabPilotosState extends State<TabPilotos> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: F1Service().pilotos(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var pilotos = snapshot.data;
        return Scaffold(
          body: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: pilotos.length,
            itemBuilder: (context, index) {
              var piloto = pilotos[index];
              Color colorEquipo = colorDesdeHex(piloto['equipo']['color']);
              Color colorTexto = colorEquipo.computeLuminance() < 0.5
                  ? Colors.white
                  : Colors.black;
              return Dismissible(
                key: ValueKey(piloto['id']),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) async {
                  await F1Service().borrarPiloto(piloto['id']);
                  setState(() {});
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kSecondaryColor, colorEquipo],
                      begin: AlignmentGeometry.topLeft,
                      end: AlignmentGeometry.bottomRight,
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorEquipo,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        piloto['numero'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: colorTexto,
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          '${piloto['nombre']} ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          piloto['apellido'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      piloto['equipo']['nombre'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
