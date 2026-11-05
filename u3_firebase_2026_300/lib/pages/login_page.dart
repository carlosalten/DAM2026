import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  String mensajeError = "";
  bool hayError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.shieldAccount,
                  color: Colors.blue.shade600,
                  size: 50,
                ),
                Text('INGRESO A LA APP'),
                TextFormField(
                  controller: emailCtrl,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordCtrl,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        hayError = false;
                        mensajeError = "";
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text.trim(),
                        );
                      } on FirebaseAuthException catch (ex) {
                        // print(ex.code);
                        hayError = true;
                        switch (ex.code) {
                          case 'channel-error':
                            mensajeError = "Ingrese sus credenciales";
                            break;
                          case 'invalid-email':
                            mensajeError = "Email no válido";
                            break;
                          case 'invalid-credential':
                            mensajeError = "Credenciales no válidas";
                            break;
                          case 'user-disabled':
                            mensajeError = "Cuenta no válida";
                            break;
                          default:
                            mensajeError = "No se pudo iniciar sesión";
                        }
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                hayError
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                        height: 45,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          border: Border.all(color: Colors.red.shade200),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(MdiIcons.alert, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              mensajeError,
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
