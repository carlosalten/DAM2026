import 'package:f1_cliente_300/constants.dart';
import 'package:f1_cliente_300/data/paises.dart';
import 'package:f1_cliente_300/pages/equipo_detalle.dart';
import 'package:f1_cliente_300/services/f1_service.dart';
import 'package:f1_cliente_300/utils/color_desde_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (dialogContext) => AlertDialog(
                  backgroundColor: kTextColor,
                  title: Text('Agregar Equipo', style: TextStyle(fontSize: 18)),
                  content: Form(
                    key: formAgregar,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //nombre del equipo
                        TextFormField(
                          controller: nombreCtrl,
                          decoration: InputDecoration(labelText: 'Nombre'),
                        ),
                        SizedBox(height: 10),

                        //jefe del equipo
                        TextFormField(
                          controller: jefeCtrl,
                          decoration: InputDecoration(
                            labelText: 'Jefe de equipo',
                          ),
                        ),
                        SizedBox(height: 10),

                        //color
                        TextFormField(
                          controller: colorCtrl,
                          decoration: InputDecoration(
                            labelText: 'Color (hex)',
                            hintText: 'FF8000',
                          ),
                          maxLength: 6,
                        ),
                        SizedBox(height: 10),

                        //pais
                        DropdownButtonFormField<String>(
                          dropdownColor: kTextColor,
                          decoration: InputDecoration(labelText: 'País'),
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
                    FilledButton(onPressed: () {}, child: Text('Agregar')),
                  ],
                ),
              );
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
