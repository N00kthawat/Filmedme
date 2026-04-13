class AuthSession {
  const AuthSession({
    required this.token,
    required this.userId,
    required this.email,
    required this.handle,
    required this.displayName,
  });

  final String token;
  final String userId;
  final String email;
  final String handle;
  final String displayName;

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'email': email,
      'handle': handle,
      'displayName': displayName,
    };
  }

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      token: _readString(json['token']),
      userId: _readString(json['userId']),
      email: _readString(json['email']),
      handle: _readString(json['handle']),
      displayName: _readString(json['displayName']),
    );
  }

  factory AuthSession.fromLoginPayload(Map<String, dynamic> json) {
    final user = _readMap(json['user']);
    final profile = _readMap(json['profile']);

    return AuthSession(
      token: _readString(json['token']),
      userId: _readString(user['id']),
      email: _readString(user['email']),
      handle: _readString(profile['handle']),
      displayName: _readString(profile['displayName']),
    );
  }

  static String _readString(dynamic value) {
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    throw const FormatException('Invalid auth payload');
  }

  static Map<String, dynamic> _readMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, item) => MapEntry('$key', item));
    }
    return const <String, dynamic>{};
  }
}
