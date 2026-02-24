import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';

void main() {
  group('SignupScreen Widget Tests', () {
    testWidgets('SignupScreen displays registration form', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      // Verify screen elements
      expect(find.byType(TextFormField), findsAtLeastNWidgets(3));
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('SignupScreen validates password match', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      // Find password fields and enter mismatched passwords
      final textFields = find.byType(TextFormField);
      if (textFields.evaluate().length >= 2) {
        await tester.enterText(textFields.at(1), 'password123');
        await tester.enterText(textFields.at(2), 'password456');
        await tester.pump();

        // Should show password mismatch error
        expect(find.text('Passwords do not match'), findsOneWidget);
      }
    });
  });
}
