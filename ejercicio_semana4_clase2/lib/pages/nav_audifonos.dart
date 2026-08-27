import 'package:ejercicio_semana4_clase2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class NavAudifonos extends StatelessWidget {
  const NavAudifonos({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.headphones, size: 30, color: kTertiaryColor),
          Text(
            'Audífonos',
            style: TextStyle(color: kTertiaryColor, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
