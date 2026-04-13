import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:filmedme/app/app.dart';
import 'package:filmedme/core/theme/theme_controller.dart';

void main() {
  testWidgets('Filmedme app renders main navigation', (tester) async {
    await tester.pumpWidget(FilmedmeApp(themeController: ThemeController(ThemeMode.system)));
    await tester.pumpAndSettle();

    expect(find.text('Filmedme'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Studio'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
  });
}
