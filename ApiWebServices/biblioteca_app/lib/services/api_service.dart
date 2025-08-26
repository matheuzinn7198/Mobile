import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "http://10.109.197.5:3010";

  // GET (Listar todos os Recursos)
  static Future<List<dynamic>> getList(String path) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path"));
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Carregar Lista de $path");
  }

  // GET (Listar um Único Recurso)
  static Future<Map<String, dynamic>> getOne(String path, String id) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Carregar Recurso de $path");
  }

  // POST (Criar novo Recurso)
  static Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse("$_baseUrl/$path"),
      headers: {"Content-Type": "application/json"}, // corrigido
      body: json.encode(body),
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao Criar Recurso em $path");
  }

  // PUT (Atualizar Recurso)
  static Future<Map<String, dynamic>> put(String path, Map<String, dynamic> body, String id) async {
    final res = await http.put(
      Uri.parse("$_baseUrl/$path/$id"),
      headers: {"Content-Type": "application/json"}, // corrigido
      body: json.encode(body),
    );
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Alterar Recurso em $path");
  }

  // DELETE (Apagar Recurso)
  static Future<void> delete(String path, String id) async {
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode != 200) throw Exception("Falha ao Deletar Recurso $path");
  }
}