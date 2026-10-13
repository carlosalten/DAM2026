import 'package:f1_cliente_300/constants.dart';
import 'package:f1_cliente_300/data/paises.dart';
import 'package:f1_cliente_300/services/f1_service.dart';
import 'package:flutter/material.dart';

class EquipoEditar extends StatefulWidget {
  const EquipoEditar({
    super.key,
    required this.equipoId,
    this.colorEquipo = kPrimaryColor,
  });

  final int equipoId;
  final Color colorEquipo;

  @override
  State<EquipoEditar> createState() => _EquipoEditarState();
}

class _EquipoEditarState extends State<EquipoEditar> {
  final nombreCtrl = TextEditingController();
  final jefeCtrl = TextEditingController();
  final colorCtrl = TextEditingController();
  String? paisSeleccionado;
  bool guardando = false;
  Map<String, dynamic> errores = {};

  late final Future futureEquipo;
  late final Color colorLetra;

  @override
  void initState() {
    super.initState();
    futureEquipo = F1Service().equipo(widget.equipoId).then((equipo) {
      nombreCtrl.text = equipo['nombre'];
      jefeCtrl.text = equipo['jefe'];
      colorCtrl.text = equipo['color'];
      paisSeleccionado = equipo['pais'];
      colorLetra = widget.colorEquipo.computeLuminance() < 0.5
          ? Colors.white
          : Colors.black;
      return equipo;
    });
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    jefeCtrl.dispose();
    colorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: CircularProgressIndicator());
    return FutureBuilder(
      future: futureEquipo,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          body = Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData &&
            snapshot.connectionState != ConnectionState.waiting) {
          body = Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
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
                          initialValue: paisSeleccionado,
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
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        if (guardando) return;
                        guardando = true;

                        try {
                          var respuesta = await F1Service().editarEquipo(
                            widget.equipoId,
                            nombreCtrl.text.trim(),
                            jefeCtrl.text.trim(),
                            colorCtrl.text.trim(),
                            paisSeleccionado ?? '',
                          );

                          //si es usuario salió de la página
                          if (!context.mounted) return;

                          //si API retorna error, detener la ejecución
                          if (respuesta.containsKey('errors')) {
                            setState(() => errores = respuesta['errors']);
                            return;
                          }

                          Navigator.pop(context);
                        } finally {
                          guardando = false;
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: widget.colorEquipo,
                      ),
                      child: Text(
                        'Editar Equipo',
                        style: TextStyle(fontSize: 16, color: colorLetra),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
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
                Text('Editar Equipo'),
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
