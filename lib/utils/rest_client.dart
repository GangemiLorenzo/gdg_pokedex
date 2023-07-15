import 'dart:convert';

import 'package:http/http.dart' as http;

class RestClient {
  RestClient();

  Future<http.Response> get({
    required String api,
  }) async {
    final httpClient = http.Client();
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    return httpClient.get(
      Uri.parse(api),
      headers: headers,
    );
  }

  Future<http.Response> post({
    required String api,
    Map<String, dynamic>? body,
  }) async {
    final httpClient = http.Client();
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    return httpClient.post(
      Uri.parse(api),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> put({
    required String api,
    required Map<String, dynamic>? body,
  }) async {
    final httpClient = http.Client();
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    return httpClient.put(
      Uri.parse(api),
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
