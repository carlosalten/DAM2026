import 'package:f1_cliente/constants.dart';
import 'package:f1_cliente/pages/piloto_agregar.dart';
import 'package:f1_cliente/services/f1_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class EquipoDetalle extends StatefulWidget {
  const EquipoDetalle({
    super.key,
    required this.equipoId,
    this.colorEquipo = kPrimaryColor,
  });

  final int equipoId;
  final Color colorEquipo;

  @override
  State<EquipoDetalle> createState() => _EquipoDetalleState();
}

class _EquipoDetalleState extends State<EquipoDetalle> {
  bool borrando = false;

  @override
  Widget build(BuildContext context) {
    String titulo = 'Cargando...';
    Widget body = Center(child: CircularProgressIndicator());

    return FutureBuilder(
      future: F1Service().equipo(widget.equipoId),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          titulo = "Error :(";
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
                Divider(color: widget.colorEquipo, thickness: 4),
                Row(
                  children: [
                    Text('Jefe de equipo:'),
                    Text(
                      equipo['jefe'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Text(
                    'PILOTOS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: equipo['pilotos'].length,
                    itemBuilder: (context, index) {
                      var piloto = equipo['pilotos'][index];
                      return ListTile(
                        leading: Icon(
                          MdiIcons.racingHelmet,
                          color: widget.colorEquipo,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('${piloto['nombre']} '),
                            Text(
                              piloto['apellido'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  'Borrar Piloto',
                                  style: TextStyle(fontSize: 18),
                                ),
                                content: Text(
                                  '¿Confirma borrar el piloto ${piloto['nombre']} ${piloto['apellido']}?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: Text('Cancelar'),
                                  ),
                                  FilledButton(
                                    onPressed: () async {
                                      if (borrando) return;
                                      borrando = true;

                                      try {
                                        final messenger = ScaffoldMessenger.of(
                                          context,
                                        );

                                        bool borradoOk = await F1Service()
                                            .borrarPiloto(piloto['id']);

                                        if (!mounted ||
                                            !dialogContext.mounted) {
                                          return;
                                        }

                                        messenger.showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 2),
                                            backgroundColor: borradoOk
                                                ? kSecondaryColor
                                                : Colors.yellow.shade800,
                                            content: Text(
                                              borradoOk
                                                  ? 'Se borró el piloto ${piloto['nombre']} ${piloto['apellido']}'
                                                  : 'No se pudo borrar el piloto :(',
                                            ),
                                          ),
                                        );

                                        Navigator.pop(dialogContext);
                                        setState(() {});
                                      } finally {
                                        borrando = false;
                                      }
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                    ),
                                    child: Text('Borrar Piloto'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(MdiIcons.trashCan, color: kPrimaryColor),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PilotoAgregar(
                          equipoId: widget.equipoId,
                          colorEquipo: widget.colorEquipo,
                        ),
                      ),
                    ).then((_) => setState(() {})),
                    style: FilledButton.styleFrom(
                      backgroundColor: widget.colorEquipo,
                    ),
                    child: Text('Agregar Piloto'),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titulo, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 16,
                  child: Image.asset('assets/images/logo_f1.png'),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.colorEquipo, kSecondaryColor],
                ),
              ),
            ),
          ),
          body: body,
        );
      },
    );
  }
}
