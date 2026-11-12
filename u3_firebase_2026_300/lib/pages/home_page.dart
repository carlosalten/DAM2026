import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:u3_firebase_2026_300/services/auth_service.dart';
import 'package:u3_firebase_2026_300/services/fs_service.dart';
import 'package:u3_firebase_2026_300/utils/format_utils.dart';

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
  bool guardando = false;
  final formAgregarKey = GlobalKey<FormState>();
  final formEditarKey = GlobalKey<FormState>();

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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder(
          stream: FsService().productos(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            var productos = snapshot.data!.docs;
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                var producto = productos[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          nombreCtrl.text = producto['nombre'];
                          precioCtrl.text = producto['precio'].toString();
                          stockCtrl.text = producto['stock'].toString();
                          showDialog(
                            context: context,
                            builder: (editDialogContext) {
                              return AlertDialog(
                                title: Text(
                                  'Editar Producto',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Form(
                                  key: formEditarKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: nombreCtrl,
                                        decoration: InputDecoration(
                                          labelText: 'Nombre',
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Indique el nombre del producto';
                                          }

                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: precioCtrl,
                                        decoration: InputDecoration(
                                          labelText: 'Precio',
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Indique el precio del producto';
                                          }

                                          if (int.tryParse(value.trim()) ==
                                              null) {
                                            return 'El precio debe ser un número entero';
                                          }

                                          int precio = int.parse(value.trim());
                                          if (precio < 0) {
                                            return 'El precio debe ser mayor o igual a cero';
                                          }

                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: stockCtrl,
                                        decoration: InputDecoration(
                                          labelText: 'Stock',
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Indique el stock del producto';
                                          }

                                          if (int.tryParse(value.trim()) ==
                                              null) {
                                            return 'El stock debe ser un número entero';
                                          }

                                          int stock = int.parse(value.trim());
                                          if (stock < 0) {
                                            return 'El stock debe ser mayor o igual a cero';
                                          }

                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(editDialogContext),
                                    child: Text('Cancelar'),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      if (!formEditarKey.currentState!
                                          .validate()) {
                                        return;
                                      }

                                      try {
                                        if (guardando) {
                                          return;
                                        }
                                        guardando = true;

                                        FsService().editarProducto(
                                          producto.id,
                                          nombreCtrl.text.trim(),
                                          int.tryParse(
                                                precioCtrl.text.trim(),
                                              ) ??
                                              -1,
                                          int.tryParse(stockCtrl.text.trim()) ??
                                              -1,
                                        );

                                        if (!mounted ||
                                            !editDialogContext.mounted) {
                                          return;
                                        }

                                        Navigator.pop(editDialogContext);
                                      } finally {
                                        guardando = false;
                                      }
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                    ),
                                    child: Text('Editar Producto'),
                                  ),
                                ],
                              );
                            },
                          ).then((_) => limpiarForm());
                        },
                        icon: MdiIcons.pen,
                        label: 'Editar',
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          FsService().borrarProducto(producto.id);
                        },
                        icon: MdiIcons.trashCan,
                        label: 'Borrar',
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(
                      MdiIcons.packageVariantClosed,
                      color: Colors.deepOrange,
                      size: 30,
                    ),
                    title: Text(producto['nombre']),
                    subtitle: Text(
                      '${producto['stock']} ${producto['stock'] <= 1 ? 'unidad' : 'unidades'}',
                    ),
                    trailing: Text(
                      '\$${formatearCantidad(producto['precio'])}',
                    ),
                  ),
                );
              },
            );
          },
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
                  key: formAgregarKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nombreCtrl,
                        decoration: InputDecoration(labelText: 'Nombre'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Indique el nombre del producto';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: precioCtrl,
                        decoration: InputDecoration(labelText: 'Precio'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Indique el precio del producto';
                          }

                          if (int.tryParse(value.trim()) == null) {
                            return 'El precio debe ser un número entero';
                          }

                          int precio = int.parse(value.trim());
                          if (precio < 0) {
                            return 'El precio debe ser mayor o igual a cero';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: stockCtrl,
                        decoration: InputDecoration(labelText: 'Stock'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Indique el stock del producto';
                          }

                          if (int.tryParse(value.trim()) == null) {
                            return 'El stock debe ser un número entero';
                          }

                          int stock = int.parse(value.trim());
                          if (stock < 0) {
                            return 'El stock debe ser mayor o igual a cero';
                          }

                          return null;
                        },
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
                    onPressed: () {
                      if (!formAgregarKey.currentState!.validate()) {
                        return;
                      }

                      try {
                        if (guardando) {
                          return;
                        }
                        guardando = true;

                        FsService().agregarProducto(
                          nombreCtrl.text.trim(),
                          int.tryParse(precioCtrl.text.trim()) ?? -1,
                          int.tryParse(stockCtrl.text.trim()) ?? -1,
                        );

                        if (!mounted || !dialogContext.mounted) {
                          return;
                        }

                        Navigator.pop(dialogContext);
                      } finally {
                        guardando = false;
                      }
                    },
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
