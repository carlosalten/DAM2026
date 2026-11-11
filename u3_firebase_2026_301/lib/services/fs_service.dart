import 'package:cloud_firestore/cloud_firestore.dart';

class FsService {
  // obtener los productos
  Stream<QuerySnapshot> productos() {
    // return FirebaseFirestore.instance.collection('productos').get();
    return FirebaseFirestore.instance.collection('productos').snapshots();
  }

  // agregar un producto
  Future<void> agregarProducto(String nombre, int precio, int stock) {
    return FirebaseFirestore.instance.collection('productos').doc().set({
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
    });
  }

  // borrar producto
  Future<void> borrarProducto(String id) {
    return FirebaseFirestore.instance.collection('productos').doc(id).delete();
  }

  // editar un producto
  Future<void> editarProducto(String id, String nombre, int precio, int stock) {
    return FirebaseFirestore.instance.collection('productos').doc(id).update({
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
    });
  }
}
