import 'package:f1_cliente/constants.dart';
import 'package:f1_cliente/data/paises.dart';
import 'package:f1_cliente/services/f1_service.dart';
import 'package:f1_cliente/utils/fechas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class PilotoAgregar extends StatefulWidget {
  const PilotoAgregar({
    super.key,
    required this.equipoId,
    this.colorEquipo = kPrimaryColor,
  });

  final int equipoId;
  final Color colorEquipo;

  @override
  State<PilotoAgregar> createState() => _PilotoAgregarState();
}

class _PilotoAgregarState extends State<PilotoAgregar> {
  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final numeroCtrl = TextEditingController();
  final puntosCtrl = TextEditingController();
  String? paisSeleccionado;
  bool guardando = false;
  Map<String, dynamic> errores = {};
  DateTime nacimientoSeleccionado = DateTime.now();

  @override
  void dispose() {
    nombreCtrl.dispose();
    apellidoCtrl.dispose();
    numeroCtrl.dispose();
    puntosCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Nuevo Piloto", style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Form(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        errorText: errores['nombre']?[0],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: apellidoCtrl,
                      decoration: InputDecoration(
                        labelText: 'Apellido',
                        errorText: errores['apellido']?[0],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: numeroCtrl,
                      decoration: InputDecoration(
                        labelText: 'Número del Auto',
                        errorText: errores['numero']?[0],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: puntosCtrl,
                      decoration: InputDecoration(
                        labelText: 'Puntos',
                        errorText: errores['puntos']?[0],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Fecha de nacimiento: '),
                        Text(
                          formatearFecha(nacimientoSeleccionado.toString()),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(1970),
                              lastDate: DateTime.now(),
                              initialDate: nacimientoSeleccionado,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: kPrimaryColor,
                                      onPrimary: Colors.white,
                                      surface: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            ).then((nacimiento) {
                              if (nacimiento != null) {
                                setState(() {
                                  nacimientoSeleccionado = nacimiento;
                                });
                              }
                            });
                          },
                          icon: Icon(MdiIcons.calendar),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                  ],
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (guardando) return;
                    guardando = true;

                    try {
                      var respuesta = await F1Service().agregarPiloto(
                        nombreCtrl.text.trim(),
                        apellidoCtrl.text.trim(),
                        int.tryParse(numeroCtrl.text.trim()) ?? 0,
                        int.tryParse(puntosCtrl.text.trim()) ?? -1,
                        paisSeleccionado ?? '',
                        widget.equipoId,
                        nacimientoSeleccionado,
                      );

                      if (!context.mounted) return;

                      if (respuesta.containsKey('errors')) {
                        setState(() {
                          errores = respuesta['errors'];
                        });

                        return;
                      }

                      Navigator.pop(context);
                    } finally {
                      guardando = false;
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                  ),
                  child: Text('Agregar Piloto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
