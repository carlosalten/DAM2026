import 'package:intl/intl.dart';

/// Formatea una cantidad con punto como separador de miles.
/// Ejemplo: 1234567 -> "1.234.567"
String formatearCantidad(num cantidad, {int decimales = 0}) {
  final formato = NumberFormat.decimalPatternDigits(
    locale: 'es_CL', // usa "." para miles y "," para decimales
    decimalDigits: decimales,
  );
  return formato.format(cantidad);
}
