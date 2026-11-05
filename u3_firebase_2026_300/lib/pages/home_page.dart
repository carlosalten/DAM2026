import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:u3_firebase_2026_300/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  @override
  void initState() {
    AuthService().currentUser().then((u) {
      if (!mounted) return;
      setState(() {
        user = u;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        leading: Icon(MdiIcons.shieldAccount, color: Colors.white, size: 30),
        title: Text(
          user?.email ?? 'Cargando usuario...',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) => FirebaseAuth.instance.signOut(),
            iconColor: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text(
                  'Cerrar sesión',
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              ),
              // PopupMenuItem(
              //   value: 'otro',
              //   child: Text(
              //     'Otra opción',
              //     style: TextStyle(color: Colors.blue.shade700),
              //   ),
              // ),
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
            OutlinedButton(
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
