import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const _themeKey = 'app_theme_mode';

  ThemeMode _themeMode;
  ThemeController(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  static Future<ThemeController> create() async {
    final prefs = await SharedPreferences.getInstance();
    final modeString = prefs.getString(_themeKey) ?? 'system';
    
    ThemeMode mode;
    switch (modeString) {
      case 'light':
        mode = ThemeMode.light;
        break;
      case 'dark':
        mode = ThemeMode.dark;
        break;
      default:
        mode = ThemeMode.system;
    }
    
    return ThemeController(mode);
  }

  Future<void> updateThemeMode(ThemeMode? newMode) async {
    if (newMode == null || newMode == _themeMode) return;

    _themeMode = newMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String modeString;
    switch (newMode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      default:
        modeString = 'system';
    }
    await prefs.setString(_themeKey, modeString);
  }
}
