import 'package:f1_cliente_300/constants.dart';
import 'package:f1_cliente_300/data/paises.dart';
import 'package:f1_cliente_300/services/f1_service.dart';
import 'package:flutter/material.dart';

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
  final puntosCtrl = TextEditingController();
  String? paisSeleccionado;
  bool guardando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.colorEquipo, kSecondaryColor],
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Nuevo Piloto'),
            SizedBox(
              width: 50,
              child: Image.asset('assets/images/logo_f1.png'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: apellidoCtrl,
                      decoration: InputDecoration(labelText: 'Apellido'),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: puntosCtrl,
                      decoration: InputDecoration(labelText: 'Puntos'),
                      keyboardType: TextInputType.number,
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
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  //prevenir doble click
                  if (guardando) return;
                  guardando = true;

                  try {
                    var respuesta = await F1Service().agregarPiloto(
                      nombreCtrl.text.trim(),
                      apellidoCtrl.text.trim(),
                      int.tryParse(puntosCtrl.text.trim()) ?? 0,
                      paisSeleccionado!,
                      widget.equipoId,
                    );

                    //si el usuario salió de la página
                    if (!context.mounted) return;

                    //si hay errores de validación (pendiente de implementar)
                    if (respuesta.containsKey('errors')) return;

                    //todo salió bien, volver a la página anterior.
                    Navigator.pop(context);
                  } finally {
                    guardando = false;
                  }
                },
                style: FilledButton.styleFrom(backgroundColor: kSecondaryColor),
                child: Text('Agregar Piloto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
