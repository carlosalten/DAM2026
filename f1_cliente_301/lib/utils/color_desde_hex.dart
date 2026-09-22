import 'package:flutter/material.dart';

Color colorDesdeHex(String hex) {
  final String codigo = hex.replaceFirst('#', '');
  return Color(int.parse('FF$codigo', radix: 16));
}
