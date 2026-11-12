import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../core/constants/api_config.dart';

/// Erro tratável com mensagem pronta para a tela.
class ApiException implements Exception {
  const ApiException(this.mensagem);
  final String mensagem;

  @override
  String toString() => mensagem;
}

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<dynamic> get(String caminho, {Map<String, String>? query}) =>
      _enviar(() => _client.get(_uri(caminho, query)));

  Future<dynamic> post(String caminho, Map<String, dynamic> corpo) => _enviar(
    () => _client.post(
      _uri(caminho),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(corpo),
    ),
  );

  Uri _uri(String caminho, [Map<String, String>? query]) =>
      Uri.parse('${ApiConfig.baseUrl}$caminho').replace(queryParameters: query);

  Future<dynamic> _enviar(Future<http.Response> Function() chamada) async {
    try {
      final resposta = await chamada().timeout(ApiConfig.timeout);
      if (resposta.statusCode == 400) {
        throw ApiException(_mensagemDe(resposta) ?? 'Dados inválidos.');
      }
      if (resposta.statusCode < 200 || resposta.statusCode >= 300) {
        throw const ApiException(
          'Não deu certo agora. Tente de novo em instantes.',
        );
      }
      return jsonDecode(utf8.decode(resposta.bodyBytes));
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException('A conexão demorou demais. Tente de novo.');
    } on SocketException {
      throw const ApiException(
        'Sem internet. Confira a conexão e tente de novo.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Sem internet. Confira a conexão e tente de novo.',
      );
    } on FormatException {
      throw const ApiException('Não deu certo. Tente de novo em instantes.');
    }
  }

  String? _mensagemDe(http.Response resposta) {
    try {
      final corpo = jsonDecode(utf8.decode(resposta.bodyBytes));
      return corpo is Map ? corpo['mensagem'] as String? : null;
    } on FormatException {
      return null;
    }
  }
}
