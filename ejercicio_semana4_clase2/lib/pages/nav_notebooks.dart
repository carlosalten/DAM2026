import 'package:ejercicio_semana4_clase2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class NavNotebooks extends StatelessWidget {
  const NavNotebooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.laptop, color: kTertiaryColor, size: 40),
          Text(
            'Notebooks',
            style: TextStyle(color: kTertiaryColor, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
