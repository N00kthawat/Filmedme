import 'package:flutter/material.dart';

ThemeData buildFilmedmeTheme() {
  const sand = Color(0xFFE8D9C6);
  const ink = Color(0xFF161412);
  const charcoal = Color(0xFF24211E);
  const fog = Color(0xFFF6F1E9);
  const muted = Color(0xFF8A8178);
  const line = Color(0xFFD4C8BB);

  final scheme = ColorScheme.fromSeed(
    seedColor: sand,
    brightness: Brightness.light,
    primary: ink,
    secondary: sand,
    surface: fog,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme.copyWith(
      surface: fog,
      onSurface: ink,
      outline: line,
      secondaryContainer: sand.withValues(alpha: 0.55),
    ),
    scaffoldBackgroundColor: fog,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 36,
        height: 1.02,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        height: 1.1,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ink,
      ),
      bodyLarge: TextStyle(fontSize: 15, height: 1.5, color: charcoal),
      bodyMedium: TextStyle(fontSize: 13, height: 1.45, color: muted),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ink,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: ink,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
    ),
    cardTheme: CardThemeData(
      margin: EdgeInsets.zero,
      color: Colors.white.withValues(alpha: 0.72),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: line),
      ),
    ),
    dividerTheme: const DividerThemeData(color: line, thickness: 1, space: 1),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: ink,
      disabledColor: sand.withValues(alpha: 0.35),
      labelStyle: const TextStyle(fontWeight: FontWeight.w600, color: ink),
      secondaryLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: line),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white.withValues(alpha: 0.82),
      indicatorColor: sand,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
          color: ink,
        ),
      ),
    ),
  );
}
