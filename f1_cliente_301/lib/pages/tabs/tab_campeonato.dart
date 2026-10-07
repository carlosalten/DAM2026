import 'package:f1_cliente/services/f1_service.dart';
import 'package:f1_cliente/utils/color_desde_hex.dart';
import 'package:flutter/material.dart';

class TabCampeonato extends StatelessWidget {
  const TabCampeonato({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: F1Service().clasificacion(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var pilotos = snapshot.data;
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => Divider(),
          itemCount: pilotos.length,
          itemBuilder: (context, index) {
            var piloto = pilotos[index];
            var equipo = piloto['equipo'];
            Color colorEquipo = colorDesdeHex(equipo['color']);
            //computeLuminance devuelve un double entre 0.0 y 1.0.
            //0.0 es negro puro, 1.0 es blanco puro.
            //es una medida de qué tan oscuro es el color.
            Color colorTexto = colorEquipo.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white;

            return ListTile(
              tileColor: Colors.grey.shade200,
              leading: Text(
                (index + 1).toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              title: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorEquipo,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${piloto['numero']}',
                      style: TextStyle(
                        color: colorTexto,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(' ${piloto['nombre']} '),
                  Text(
                    piloto['apellido'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              subtitle: Text(
                equipo['nombre'],
                style: TextStyle(color: colorEquipo),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${piloto['puntos']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text('Puntos'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
