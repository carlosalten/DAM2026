import 'package:ejercicio_semana4_clase2/constants.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_audifonos.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_celulares.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_notebooks.dart';
import 'package:ejercicio_semana4_clase2/pages/nav_tablets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
        backgroundColor: kTertiaryColor,
        foregroundColor: Colors.white,
        title: Text('NavigationDrawer'),
      ),
      body: IndexedStack(index: _paginaSeleccionada, children: _paginas),
      drawer: NavigationDrawer(
        backgroundColor: kSecondaryColor,
        indicatorColor: Colors.white,
        selectedIndex: _paginaSeleccionada,
        onDestinationSelected: (indicePagina) {
          setState(() {
            _paginaSeleccionada = indicePagina;
          });
          Navigator.pop(context);
        },
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      image: DecorationImage(
                        image: AssetImage('assets/images/user.png'),
                      ),
                    ),
                  ),
                ),
                Text('Bender', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(MdiIcons.headphones),
            label: Text('Audífonos'),
          ),
          NavigationDrawerDestination(
            icon: Icon(MdiIcons.cellphone),
            label: Text('Celulares'),
          ),
          NavigationDrawerDestination(
            icon: Icon(MdiIcons.laptop),
            label: Text('Notebooks'),
          ),
          NavigationDrawerDestination(
            icon: Icon(MdiIcons.tablet),
            label: Text('Tablets'),
          ),
        ],
      ),
    );
  }
}
