import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color bg;
  final Color surface;
  final Color line;
  final Color ink;
  final Color muted;

  const AppColors({
    required this.bg,
    required this.surface,
    required this.line,
    required this.ink,
    required this.muted,
  });

  @override
  AppColors copyWith({
    Color? bg,
    Color? surface,
    Color? line,
    Color? ink,
    Color? muted,
  }) {
    return AppColors(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      line: line ?? this.line,
      ink: ink ?? this.ink,
      muted: muted ?? this.muted,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      line: Color.lerp(line, other.line, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
    );
  }
}

ThemeData buildFilmedmeTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  // Modern Light Theme
  const lightBg = Color(0xFFF9F9FB);
  const lightSurface = Color(0xFFFFFFFF);
  const lightLine = Color(0xFFE5E7EB);
  const lightInk = Color(0xFF111827);
  const lightMuted = Color(0xFF6B7280);

  // Modern Dark Theme (Existing App Dark Style)
  const darkBg = Color(0xFF07080B);
  const darkSurface = Color(0xFF101216);
  const darkLine = Color(0xFF23262D);
  const darkInk = Color(0xFFF3F3F5);
  const darkMuted = Color(0xFFA0A4AD);

  final appColors = AppColors(
    bg: isDark ? darkBg : lightBg,
    surface: isDark ? darkSurface : lightSurface,
    line: isDark ? darkLine : lightLine,
    ink: isDark ? darkInk : lightInk,
    muted: isDark ? darkMuted : lightMuted,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: appColors.bg,
    extensions: [appColors],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: appColors.ink,
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(color: appColors.line, thickness: 1, space: 1),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: appColors.ink),
      bodyMedium: TextStyle(color: appColors.muted),
    ),
  );
}
