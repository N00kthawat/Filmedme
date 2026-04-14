import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_session.dart';

class AuthSessionStore {
  static const _key = 'filmedme_auth_session_v1';

  // ---------------------------------------------------------------------------
  // อ่าน Session (เรียกตอนเปิดแอป)
  // ---------------------------------------------------------------------------
  Future<AuthSession?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return AuthSession.fromJson(decoded);
      if (decoded is Map) {
        return AuthSession.fromJson(decoded.map((k, v) => MapEntry('$k', v)));
      }
    } catch (_) {
      await prefs.remove(_key);
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // บันทึก Session (เรียกหลัง login หรือ register สำเร็จ)
  // ---------------------------------------------------------------------------
  Future<void> save(AuthSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(session.toJson()));
  }
  // ---------------------------------------------------------------------------
  // ลบ Session (เรียกตอน logout)
  // ---------------------------------------------------------------------------

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
