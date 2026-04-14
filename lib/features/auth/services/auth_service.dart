import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/config/app_env.dart';
import '../models/auth_session.dart';

/// Error ที่เกิดจาก Backend เช่น รหัสผ่านผิด, อีเมลซ้ำ
///
/// แยกออกจาก Exception ทั่วไปเพื่อให้ catch ได้เฉพาะเจาะจง
class AuthApiException implements Exception {
  const AuthApiException(this.message);

  /// ข้อความ error จาก backend ที่นำไปแสดงบนหน้าจอได้เลย
  final String message;
}

class AuthService {
  /// [client] ใช้สำหรับ inject ใน Unit Test — production ใช้ค่า default
  AuthService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  // ---------------------------------------------------------------------------
  // Login
  // ---------------------------------------------------------------------------

  /// ส่ง email + password ไปยัง backend
  ///
  /// สำเร็จ → คืน [AuthSession] พร้อม token
  /// ล้มเหลว → throw [AuthApiException] พร้อม error message จาก backend
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('${AppEnv.apiBaseUrl}/auth/login'),
      headers: const {'content-type': 'application/json'},
      body: jsonEncode({
        'email': email.trim(),
        'password': password,
      }),
    );

    final body = _parseJsonBody(response.bodyBytes);

    if (response.statusCode != 200) {
      throw AuthApiException(_extractErrorMessage(body));
    }

    return AuthSession.fromLoginPayload(body);
  }

  // ---------------------------------------------------------------------------
  // Register
  // ---------------------------------------------------------------------------

  /// สมัครบัญชีใหม่ด้วย handle + email + password
  ///
  /// สำเร็จ (HTTP 201) → คืน [AuthSession] พร้อม token เหมือน login
  /// ล้มเหลว → throw [AuthApiException]
  Future<AuthSession> register({
    required String handle,
    required String email,
    required String password,
  }) async {
    final cleanHandle = handle.trim();

    final response = await _client.post(
      Uri.parse('${AppEnv.apiBaseUrl}/auth/register'),
      headers: const {'content-type': 'application/json'},
      body: jsonEncode({
        'handle': cleanHandle,
        'displayName': cleanHandle, // ใช้ handle เป็น displayName เริ่มต้น
        'email': email.trim(),
        'password': password,
      }),
    );

    final body = _parseJsonBody(response.bodyBytes);

    if (response.statusCode != 201) {
      throw AuthApiException(_extractErrorMessage(body));
    }

    return AuthSession.fromLoginPayload(body);
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// ปิด HTTP client — เรียกเมื่อ Widget ถูก dispose
  void dispose() => _client.close();

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// แปลง response bytes → Map (รองรับ empty body)
  Map<String, dynamic> _parseJsonBody(List<int> bytes) {
    if (bytes.isEmpty) return const {};
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.map((k, v) => MapEntry('$k', v));
    } catch (_) {}
    return const {};
  }

  /// ดึง error message จาก body — ถ้าไม่มีใช้ข้อความ fallback
  String _extractErrorMessage(Map<String, dynamic> body) {
    final msg = body['message'];
    if (msg is String && msg.trim().isNotEmpty) return msg.trim();
    return 'Login failed. Please check your email/password and try again.';
  }
}
