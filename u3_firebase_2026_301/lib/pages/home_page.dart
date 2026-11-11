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
  final nombreCtrl = TextEditingController();
  final precioCtrl = TextEditingController();
  final stockCtrl = TextEditingController();

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
  void dispose() {
    nombreCtrl.dispose();
    precioCtrl.dispose();
    stockCtrl.dispose();
    super.dispose();
  }

  void limpiarForm() {
    nombreCtrl.clear();
    precioCtrl.clear();
    stockCtrl.clear();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: Text(
                  'Agregar Producto',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nombreCtrl,
                        decoration: InputDecoration(labelText: 'Nombre'),
                      ),
                      TextFormField(
                        controller: precioCtrl,
                        decoration: InputDecoration(labelText: 'Precio'),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: stockCtrl,
                        decoration: InputDecoration(labelText: 'Stock'),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text('Cancelar'),
                  ),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: Text('Agregar Producto'),
                  ),
                ],
              );
            },
          ).then((_) => limpiarForm());
        },
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
