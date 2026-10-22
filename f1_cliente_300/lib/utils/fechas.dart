import 'package:intl/intl.dart';

String formatearFecha(String fecha) {
  DateTime fechaDateTime = DateTime.parse(fecha);
  return DateFormat('dd/MM/yyyy').format(fechaDateTime);
}

// String formatearHora(String fecha) {
//   DateTime fechaDateTime = DateTime.parse(fecha);
//   return DateFormat('hh:mm:ss').format(fechaDateTime);
// }

String formatearFechaAPI(DateTime fecha) {
  return DateFormat('yyyy-MM-dd').format(fecha);
}
