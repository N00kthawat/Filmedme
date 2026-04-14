// =============================================================================
// AuthSession — โมเดลข้อมูล Session ของผู้ใช้หลังจาก Login สำเร็จ
//
// เก็บข้อมูลที่ได้จาก backend แล้วนำไปใช้ทั่วทั้งแอป เช่น:
//   - token: ใช้แนบใน HTTP Header เพื่อเรียก API ที่ต้องการสิทธิ์
//   - userId, email, handle, displayName: ข้อมูลโปรไฟล์พื้นฐาน
// =============================================================================

class AuthSession {
  const AuthSession({
    required this.token,
    required this.userId,
    required this.email,
    required this.handle,
    required this.displayName,
  });

  /// JWT Token — แนบใน Authorization Header ทุกครั้งที่เรียก API
  final String token;
  final String userId;
  final String email;
  final String handle;
  final String displayName;

  // ---------------------------------------------------------------------------
  // Serialization — แปลงเป็น JSON เพื่อบันทึกลง SharedPreferences
  // ---------------------------------------------------------------------------

  Map<String, dynamic> toJson() => {
        'token': token,
        'userId': userId,
        'email': email,
        'handle': handle,
        'displayName': displayName,
      };

  /// อ่าน Session กลับจาก JSON ที่เก็บไว้ใน SharedPreferences
  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      token: _str(json['token']),
      userId: _str(json['userId']),
      email: _str(json['email']),
      handle: _str(json['handle']),
      displayName: _str(json['displayName']),
    );
  }

  /// แปลง Response จาก API /auth/login และ /auth/register
  ///
  /// Backend คืน JSON รูปแบบนี้:
  /// ```json
  /// {
  ///   "token": "eyJ...",
  ///   "user":    { "id": "...", "email": "..." },
  ///   "profile": { "handle": "...", "displayName": "..." }
  /// }
  /// ```
  factory AuthSession.fromLoginPayload(Map<String, dynamic> json) {
    final user    = _map(json['user']);    
    final profile = _map(json['profile']);

    return AuthSession(
      token:       _str(json['token']),
      userId:      _str(user['id']),
      email:       _str(user['email']),
      handle:      _str(profile['handle']),
      displayName: _str(profile['displayName']),
    );
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// ดึง String จาก JSON — ถ้าค่าว่างหรือผิดรูปแบบจะ throw ทันที
  static String _str(dynamic value) {
    if (value is String && value.trim().isNotEmpty) return value.trim();
    throw const FormatException('Invalid auth payload: expected non-empty string');
  }

  /// ดึง Map จาก JSON — ถ้าไม่ใช่ Map คืน empty map แทน
  static Map<String, dynamic> _map(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return value.map((k, v) => MapEntry('$k', v));
    return const {};
  }
}
