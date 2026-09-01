import 'package:ejercicio7/pages/tab_comida.dart';
import 'package:ejercicio7/pages/tab_locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class TabBase extends StatelessWidget {
  const TabBase({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade50,
          leading: Icon(MdiIcons.food, color: Colors.orange),
          title: Row(
            children: [
              Text(
                'USM',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Eats', style: TextStyle(color: Colors.orange)),
            ],
          ),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.deepOrange,
            tabs: [
              Tab(text: 'Comida'),
              Tab(text: 'Locales'),
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: TabBarView(children: [TabComida(), TabLocales()]),
        ),
      ),
    );
  }
}
