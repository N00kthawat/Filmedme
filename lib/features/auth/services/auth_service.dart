import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/config/app_env.dart';
import '../models/auth_session.dart';

class AuthApiException implements Exception {
  const AuthApiException(this.message);

  final String message;
}

class AuthService {
  AuthService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('${AppEnv.apiBaseUrl}/auth/login');
    final response = await _client.post(
      uri,
      headers: const {'content-type': 'application/json'},
      body: jsonEncode({
        'email': email.trim(),
        'password': password,
      }),
    );

    final body = _decodeMap(response.bodyBytes);
    if (response.statusCode != 200) {
      throw AuthApiException(_extractMessage(body));
    }

    return AuthSession.fromLoginPayload(body);
  }

  Future<AuthSession> register({
    required String handle,
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('${AppEnv.apiBaseUrl}/auth/register');
    final cleanHandle = handle.trim();
    final response = await _client.post(
      uri,
      headers: const {'content-type': 'application/json'},
      body: jsonEncode({
        'handle': cleanHandle,
        'displayName': cleanHandle,
        'email': email.trim(),
        'password': password,
      }),
    );

    final body = _decodeMap(response.bodyBytes);
    if (response.statusCode != 201) {
      throw AuthApiException(_extractMessage(body));
    }

    return AuthSession.fromLoginPayload(body);
  }

  void dispose() {
    _client.close();
  }

  Map<String, dynamic> _decodeMap(List<int> bodyBytes) {
    if (bodyBytes.isEmpty) {
      return const <String, dynamic>{};
    }

    final raw = utf8.decode(bodyBytes);
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry('$key', value));
    }

    return const <String, dynamic>{};
  }

  String _extractMessage(Map<String, dynamic> payload) {
    final message = payload['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message.trim();
    }
    return 'Login failed. Please check your email/password and try again.';
  }
}
