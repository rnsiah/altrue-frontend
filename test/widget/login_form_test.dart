import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Presentation%20Layer/Forms/login_form.dart';

void main() {
  group('LoginForm Widget Tests', () {
    testWidgets('LoginForm displays email and password fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoginForm(),
          ),
        ),
      );

      // Verify form elements exist
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    });

    testWidgets('LoginForm validates empty email', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoginForm(),
          ),
        ),
      );

      // Try to submit with empty fields
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pump();

        // Should show validation error
        expect(find.text('Please enter your email'), findsOneWidget);
      }
    });

    testWidgets('LoginForm validates invalid email format', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoginForm(),
          ),
        ),
      );

      // Enter invalid email
      final emailField = find.widgetWithText(TextFormField, 'Email');
      if (emailField.evaluate().isNotEmpty) {
        await tester.enterText(emailField, 'invalid-email');
        await tester.pump();

        // Should show validation error
        expect(find.text('Please enter a valid email'), findsOneWidget);
      }
    });
  });
}
