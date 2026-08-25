import 'package:ejercicio_semana4_clase1/pages/tabs/tab_autos.dart';
import 'package:ejercicio_semana4_clase1/pages/tabs/tab_camiones.dart';
import 'package:ejercicio_semana4_clase1/pages/tabs/tab_motos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class EjemploTabs extends StatelessWidget {
  const EjemploTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          title: Text('Ejemplo Tabs'),
          leading: Icon(MdiIcons.tab),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.yellow,
            unselectedLabelColor: Colors.brown.shade50,
            tabs: [
              Tab(icon: Icon(MdiIcons.car), text: 'Autos'),
              Tab(icon: Icon(MdiIcons.motorbike), text: 'Motos'),
              Tab(icon: Icon(MdiIcons.truck), text: 'Camiones'),
            ],
          ),
        ),
        body: TabBarView(children: [TabAutos(), TabMotos(), TabCamiones()]),
      ),
    );
  }
}
