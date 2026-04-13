import 'package:flutter/material.dart';

import '../core/theme/theme_controller.dart';
import '../core/theme/theme_provider.dart';
import 'router.dart';
import 'theme.dart';

class FilmedmeApp extends StatelessWidget {
  final ThemeController themeController;
  const FilmedmeApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      notifier: themeController,
      child: Builder(
        builder: (context) {
          final themeMode = ThemeProvider.of(context).themeMode;
          return MaterialApp(
            title: 'Filmedme',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: buildFilmedmeTheme(Brightness.light),
            darkTheme: buildFilmedmeTheme(Brightness.dark),
            home: const AppRouter(),
          );
        }
      ),
    );
  }
}
