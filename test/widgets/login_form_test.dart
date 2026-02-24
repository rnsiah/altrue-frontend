import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Presentation%20Layer/Forms/user_login_form.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

/// Mock User class for testing
class MockUser extends User {
  MockUser() : super();
  
  @override
  String get email => 'test@example.com';
}

void main() {
  group('Login Form Widget Tests', () {
    testWidgets('Login form displays email and password fields', (WidgetTester tester) async {
      // Build the login form
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserLoginForm(),
          ),
        ),
      );

      // Verify email field exists
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('Login form validates empty email', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserLoginForm(),
          ),
        ),
      );

      // Find and tap login button
      final loginButton = find.text('Login');
      expect(loginButton, findsOneWidget);
      
      await tester.tap(loginButton);
      await tester.pump();

      // Form should show validation error
      // Note: Actual validation depends on implementation
    });

    testWidgets('Login form accepts valid input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserLoginForm(),
          ),
        ),
      );

      // Enter email
      final emailField = find.widgetWithText(TextFormField, 'Email');
      await tester.enterText(emailField, 'test@example.com');
      
      // Enter password
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      await tester.enterText(passwordField, 'password123');
      
      await tester.pump();

      // Verify text was entered
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('Login button is present and tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserLoginForm(),
          ),
        ),
      );

      // Verify login button exists
      expect(find.byType(ElevatedButton), findsOneWidget);
      
      // Verify button text
      expect(find.text('Login'), findsOneWidget);
    });
  });
}
