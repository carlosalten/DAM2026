import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:u3_firebase_2026/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    AuthService().currentUser().then((currentU) {
      if (!mounted) return;
      setState(() {
        user = currentU;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        leading: Icon(MdiIcons.shieldAccount, size: 30, color: Colors.white),
        title: Text(
          user?.email ?? "Cargando datos...",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (valueSeleccionado) => FirebaseAuth.instance.signOut(),
            iconColor: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('HOME PAGE'),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
