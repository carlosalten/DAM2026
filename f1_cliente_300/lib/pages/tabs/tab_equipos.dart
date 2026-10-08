import 'package:f1_cliente_300/constants.dart';
import 'package:f1_cliente_300/data/paises.dart';
import 'package:f1_cliente_300/pages/equipo_detalle.dart';
import 'package:f1_cliente_300/services/f1_service.dart';
import 'package:f1_cliente_300/utils/color_desde_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TabEquipos extends StatefulWidget {
  const TabEquipos({super.key});

  @override
  State<TabEquipos> createState() => _TabEquiposState();
}

class _TabEquiposState extends State<TabEquipos> {
  final nombreCtrl = TextEditingController();
  final jefeCtrl = TextEditingController();
  final colorCtrl = TextEditingController();
  String? paisSeleccionado;
  final formAgregar = GlobalKey<FormState>();
  bool guardando = false;
  Map<String, dynamic> errores = {};

  @override
  void dispose() {
    nombreCtrl.dispose();
    jefeCtrl.dispose();
    colorCtrl.dispose();
    super.dispose();
  }

  void _limpiarForm() {
    nombreCtrl.clear();
    jefeCtrl.clear();
    colorCtrl.clear();
    paisSeleccionado = null;
    guardando = false;
  }

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
        return Scaffold(
          body: ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Divider(),
            itemCount: equipos.length,
            itemBuilder: (context, index) {
              var equipo = equipos[index];
              Color colorEquipo = colorDesdeHex(equipo['color']);
              return Slidable(
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {},
                      backgroundColor: Colors.blue,
                      icon: MdiIcons.pen,
                      label: 'Editar',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) async {
                        final messenger = ScaffoldMessenger.of(context);
                        bool borradoOk = await F1Service().borrarEquipo(
                          equipo['id'],
                        );
                        if (!context.mounted) {
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
                                  ? 'Se borró el equipo ${equipo['nombre']}'
                                  : 'No se pudo borrar :(',
                            ),
                          ),
                        );
                        setState(() {});
                      },
                      backgroundColor: kPrimaryColor,
                      icon: MdiIcons.trashCan,
                      label: 'Borrar',
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(
                    MdiIcons.carSports,
                    size: 30,
                    color: colorEquipo,
                  ),
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
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (dialogContext) => StatefulBuilder(
                  builder: (context, setDialogState) {
                    return AlertDialog(
                      backgroundColor: kTextColor,
                      title: Text(
                        'Agregar Equipo',
                        style: TextStyle(fontSize: 18),
                      ),
                      content: Form(
                        key: formAgregar,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //nombre del equipo
                            TextFormField(
                              controller: nombreCtrl,
                              decoration: InputDecoration(
                                labelText: 'Nombre',
                                errorText: errores['nombre']?[0],
                              ),
                            ),
                            SizedBox(height: 10),

                            //jefe del equipo
                            TextFormField(
                              controller: jefeCtrl,
                              decoration: InputDecoration(
                                labelText: 'Jefe de equipo',
                                errorText: errores['jefe']?[0],
                              ),
                            ),
                            SizedBox(height: 10),

                            //color
                            TextFormField(
                              controller: colorCtrl,
                              decoration: InputDecoration(
                                labelText: 'Color (hex)',
                                hintText: 'FF8000',
                                errorText: errores['color']?[0],
                              ),
                              maxLength: 6,
                            ),
                            SizedBox(height: 10),

                            //pais
                            DropdownButtonFormField<String>(
                              dropdownColor: kTextColor,
                              decoration: InputDecoration(
                                labelText: 'País',
                                errorText: errores['pais']?[0],
                              ),
                              isExpanded: true,
                              menuMaxHeight: 300,
                              items: paises
                                  .map(
                                    (pais) => DropdownMenuItem(
                                      value: pais,
                                      child: Text(pais),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (pais) => paisSeleccionado = pais,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      //botones
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text('Cancelar'),
                        ),
                        FilledButton(
                          onPressed: () async {
                            if (guardando) return;
                            guardando = true;

                            try {
                              var respuesta = await F1Service().agregarEquipo(
                                nombreCtrl.text.trim(),
                                jefeCtrl.text.trim(),
                                colorCtrl.text.trim(),
                                paisSeleccionado ?? '',
                              );

                              //si es usuario salió de la página
                              //o salió de AlertDialog
                              //detener función
                              if (!mounted || !dialogContext.mounted) return;

                              //si API retorna error, detener la ejecución
                              if (respuesta.containsKey('errors')) {
                                setDialogState(
                                  () => errores = respuesta['errors'],
                                );
                                return;
                              }

                              Navigator.pop(dialogContext);
                              setState(() {});
                            } finally {
                              guardando = false;
                            }
                          },
                          child: Text('Agregar'),
                        ),
                      ],
                    );
                  },
                ),
              ).then((_) => _limpiarForm());
            },
            backgroundColor: kPrimaryColor,
            foregroundColor: kTextColor,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
