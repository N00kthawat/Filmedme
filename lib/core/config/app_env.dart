import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  const AppEnv._();

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // Fallback keeps app bootable for fresh clones before creating .env.
      await dotenv.load(fileName: '.env.example');
    }
  }

  static String get apiBaseUrl {
    final value =
        _platformOverrideBaseUrl() ?? dotenv.env['API_BASE_URL']?.trim();
    if (value == null || value.isEmpty) {
      throw StateError(
        'Missing API_BASE_URL. Create .env from .env.example and set backend URL.',
      );
    }
    return _normalizeLocalhost(value);
  }

  static String? _platformOverrideBaseUrl() {
    final envMap = dotenv.env;
    if (kIsWeb) {
      final web = envMap['API_BASE_URL_WEB']?.trim();
      return web == null || web.isEmpty ? null : web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final android = envMap['API_BASE_URL_ANDROID']?.trim();
        return android == null || android.isEmpty ? null : android;
      case TargetPlatform.iOS:
        final ios = envMap['API_BASE_URL_IOS']?.trim();
        return ios == null || ios.isEmpty ? null : ios;
      default:
        return null;
    }
  }

  static String _normalizeLocalhost(String raw) {
    if (kIsWeb) return raw;

    final uri = Uri.tryParse(raw);
    if (uri == null || !uri.hasAuthority) {
      return raw;
    }

    final host = uri.host.toLowerCase();
    final isLocalhost = host == 'localhost' || host == '127.0.0.1';
    if (!isLocalhost) return raw;

    if (defaultTargetPlatform == TargetPlatform.android) {
      return uri.replace(host: '10.0.2.2').toString();
    }

    return raw;
  }
}
