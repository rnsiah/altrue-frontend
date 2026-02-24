import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_actions_screen.dart';

void main() {
  group('Mission Control Dashboard Tests', () {
    testWidgets('Mission Control displays user stats', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: UserActionsScreen(),
        ),
      );

      // Allow widget to build
      await tester.pump();

      // Verify dashboard elements exist
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('Mission Control displays action buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: UserActionsScreen(),
        ),
      );

      await tester.pump();

      // Verify action buttons exist
      final buttons = find.byType(InkWell);
      expect(buttons, findsWidgets);
    });
  });
}
