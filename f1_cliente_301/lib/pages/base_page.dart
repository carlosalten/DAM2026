import 'package:f1_cliente/constants.dart';
import 'package:f1_cliente/pages/tabs/tab_campeonato.dart';
import 'package:f1_cliente/pages/tabs/tab_equipos.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kSecondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          centerTitle: true,
          title: SizedBox(
            height: 40,
            child: Image.asset(
              'assets/images/logo_f1.png',
              fit: BoxFit.contain,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Equipos'),
              Tab(text: 'Campeonato'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TabBarView(children: [TabEquipos(), TabCampeonato()]),
        ),
      ),
    );
  }
}
