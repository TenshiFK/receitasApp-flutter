import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiReceitas {
  static Future<List<dynamic>> fetchReceitas() async {
    final url =
        Uri.parse('http://10.0.2.2:3001/receitas');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao carregar as receitas');
      }
    } catch (e) {
      rethrow; // Re-lança a exceção para ser tratada pelo chamador
    }
  }

  static Future<Map<String, dynamic>> fetchDetalhesReceitas(
      {required String idReceita}) async {
    final url = Uri.parse(
        'http://10.0.2.2:3001/receitas/${idReceita}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao carregar receita');
      }
    } catch (e) {
      rethrow; // Re-lança a exceção para ser tratada pelo chamador
    }
  }
}
