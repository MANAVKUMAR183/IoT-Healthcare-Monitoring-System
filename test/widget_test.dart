// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:smart_healthcare_app/main.dart';

void main() {
  testWidgets('Patient Dashboard loads and shows welcome', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Check for Patient Dashboard title
    expect(find.text('Patient Dashboard'), findsOneWidget);
    // Check for Welcome back text
    expect(find.text('Welcome back!'), findsOneWidget);
    // Check for John Doe (default name in dashboard)
    expect(find.text('John Doe'), findsOneWidget);
  });
}
