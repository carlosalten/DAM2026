import 'package:ejercicio_semana3_clase2/constants.dart';
import 'package:ejercicio_semana3_clase2/data/f1_teams.dart';
import 'package:ejercicio_semana3_clase2/widgets/team_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        title: Text('Fórmula 1', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Icon(MdiIcons.racingHelmet, size: 36),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: f1Teams.length,
          itemBuilder: (context, index) {
            return TeamCard(
              nombre: f1Teams[index].nombre,
              imagen: f1Teams[index].imagen,
            );
          },
        ),
        // child: ListView(
        //   children: [
        //     TeamCard(nombre: 'Scuderia Ferrari', imagen: 'ferrari.jpeg'),
        //     TeamCard(nombre: 'Mercedes AMG Petronas', imagen: 'mercedes.jpeg'),
        //   ],
        // ),
      ),
    );
  }
}
