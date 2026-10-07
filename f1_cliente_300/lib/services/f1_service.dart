import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class F1Service {
  final String _apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> equipos() async {
    var respuesta = await http.get(Uri.parse('$_apiURL/equipos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body)['data'];
    }
    return [];
  }

  Future<LinkedHashMap<String, dynamic>> equipo(int equipoId) async {
    var respuesta = await http.get(Uri.parse('$_apiURL/equipos/$equipoId'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body)['data'];
    }
    return LinkedHashMap();
  }

  Future<LinkedHashMap<String, dynamic>> agregarEquipo(
    String nombre,
    String jefe,
    String color,
    String pais,
  ) async {
    var respuesta = await http.post(
      Uri.parse('$_apiURL/equipos'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'nombre': nombre,
        'jefe': jefe,
        'color': color,
        'pais': pais,
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> agregarPiloto(
    String nombre,
    String apellido,
    int numero,
    int puntos,
    String pais,
    int equipoId,
  ) async {
    var respuesta = await http.post(
      Uri.parse('$_apiURL/pilotos'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'nombre': nombre,
        'apellido': apellido,
        'numero': numero,
        'puntos': puntos,
        'pais': pais,
        'equipo_id': equipoId,
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<List<dynamic>> clasificacion() async {
    var respuesta = await http.get(Uri.parse('$_apiURL/pilotos/clasificacion'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body)['data'];
    }
    return [];
  }
}
