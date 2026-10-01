// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:underground_roast/main.dart';

void main() {
  testWidgets('Underground Roast smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const UndergroundRoastApp());

    // Verify that the title or day counter is found.
    expect(find.textContaining('GÜN 1'), findsOneWidget);
  });
}
