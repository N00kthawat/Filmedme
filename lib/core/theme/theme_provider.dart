import 'package:flutter/material.dart';

import 'theme_controller.dart';

class ThemeProvider extends InheritedNotifier<ThemeController> {
  const ThemeProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ThemeController of(BuildContext context) {
    var provider = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    return provider!.notifier!;
  }
}
