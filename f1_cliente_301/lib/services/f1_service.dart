import 'dart:convert';
import 'package:http/http.dart' as http;

class F1Service {
  final String _apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> equipos() async {
    var respuesta = await http.get(Uri.parse('$_apiURL/equipos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    return [];
  }
}
