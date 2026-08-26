import 'package:ejercicio_semana4_clase2/constants.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_audifonos.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_celulares.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_notebooks.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_tablets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _paginaSeleccionada = 0;
  final List<Widget> _paginas = [
    NavAudifonos(),
    NavCelulares(),
    NavNotebooks(),
    NavTablet(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        title: Text('NavigationBar'),
      ),
      body: IndexedStack(index: _paginaSeleccionada, children: _paginas),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(MdiIcons.headphones),
            label: 'Audífonos',
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.cellphone),
            label: 'Celulares',
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.laptop),
            label: 'Notebooks',
          ),
          NavigationDestination(icon: Icon(MdiIcons.tablet), label: 'Tablets'),
        ],
        selectedIndex: _paginaSeleccionada,
        onDestinationSelected: (indicePagina) {
          // print(indicePagina);
          setState(() {
            _paginaSeleccionada = indicePagina;
          });
        },
      ),
    );
  }
}
