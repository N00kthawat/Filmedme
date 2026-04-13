import 'package:flutter_test/flutter_test.dart';

import 'package:filmedme/app/app.dart';

void main() {
  testWidgets('Filmedme app renders main navigation', (tester) async {
    await tester.pumpWidget(const FilmedmeApp());
    await tester.pumpAndSettle();

    expect(find.text('Filmedme'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Studio'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
  });
}
