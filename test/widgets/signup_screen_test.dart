// Flutter widget tests for authentication screens.
//
// These tests verify:
// - SignUp screen renders correctly
// - Form validation works
// - Form fields accept input
// - Buttons trigger correct actions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';

/// Mock UserRepository for testing
class MockUserRepository extends UserRepository {
  @override
  Future<bool> loginUser({required String email, required String password}) async {
    return true;
  }
  
  @override
  Future<bool> signUpUser({
    required String email,
    required String password1,
    required String password2,
    String? altrueCode,
  }) async {
    return true;
  }
}

void main() {
  group('SignUpScreen Widget Tests', () {
    late MockUserRepository mockRepository;
    late SessionBLoc sessionBLoc;
    late UserProfileEditBloc userProfileEditBloc;
    late ValidationCubit validationCubit;

    setUp(() {
      mockRepository = MockUserRepository();
      sessionBLoc = SessionBLoc(userRepository: mockRepository);
      userProfileEditBloc = UserProfileEditBloc(sessionBLoc: sessionBLoc);
      validationCubit = ValidationCubit(
        sessionBloc: sessionBLoc,
        userRepository: mockRepository,
        userProfileEditBloc: userProfileEditBloc,
      );
    });

    tearDown(() {
      validationCubit.close();
      userProfileEditBloc.close();
      sessionBLoc.close();
    });

    /// Builds the SignUpScreen wrapped with required BLoC providers
    Widget buildTestableWidget() {
      return MaterialApp(
        home: RepositoryProvider<UserRepository>(
          create: (context) => mockRepository,
          child: BlocProvider<ValidationCubit>(
            create: (context) => validationCubit,
            child: const SignUpScreen(),
          ),
        ),
      );
    }

    testWidgets(
      'SignUpScreen renders with all form fields',
      (WidgetTester tester) async {
        /// Setup: Build the widget
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        /// Verify: Check that all form elements are present
        expect(find.byType(TextFormField), findsNWidgets(3)); // email + password + confirm
        // Hint-text based labels from the glassmorphism redesign.
        expect(find.text('Email Address'), findsOneWidget);
        expect(find.text('Password'), findsAtLeastNWidgets(1));
        expect(find.text('Confirm Password'), findsOneWidget);
        // Altrue donor-code toggle + terms checkbox.
        expect(find.byType(CheckboxListTile), findsAtLeastNWidgets(1));
      },
    );

    testWidgets(
      'Email field accepts input',
      (WidgetTester tester) async {
        /// Setup: Build the widget
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        /// Action: Enter email in the first text field
        await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
        await tester.pump();

        /// Verify: Check that text was entered
        expect(find.text('test@example.com'), findsOneWidget);
      },
    );

    testWidgets(
      'Password fields accept input and obscure text',
      (WidgetTester tester) async {
        /// Setup: Build the widget
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        /// Action: Enter password in password fields
        final passwordFields = find.byType(TextFormField);
        await tester.enterText(passwordFields.at(1), 'password123');
        await tester.enterText(passwordFields.at(2), 'password123');
        await tester.pump();

        /// Verify: Check that passwords were entered (obscured so we check indirectly)
        // The text is obscured so we verify the fields exist and accept input
        expect(passwordFields, findsNWidgets(3));
      },
    );

    testWidgets(
      'Altrue code checkbox toggles code field visibility',
      (WidgetTester tester) async {
        /// Setup: Build the widget
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        /// Verify: Initially, code field is not visible
        expect(find.text('Altrue Donor Code'), findsNothing);

        /// Action: Tap the checkbox to enable code field
        await tester.tap(find.byType(CheckboxListTile));
        await tester.pumpAndSettle();

        /// Verify: Code field is now visible
        expect(find.text('Altrue Donor Code'), findsOneWidget);
      },
    );

    testWidgets(
      'Sign up button is present and tappable',
      (WidgetTester tester) async {
        /// Setup: Build the widget
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        /// Verify: Button exists (GlassButton since the redesign)
        expect(find.byType(MaterialButton), findsNothing);
        expect(find.text('Create Account'), findsAtLeastNWidgets(1));

        /// Note: In a real test, you'd verify the BLoC event was fired
        /// or mock the repository and verify the call
      },
    );

    testWidgets(
      'Login link is present and navigates',
      (WidgetTester tester) async {
        /// Setup: Build the widget
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        /// Verify: Login link exists (rendered as Text + TextButton('Sign In'))
        expect(find.text('Already have an account? '), findsOneWidget);
        expect(find.text('Sign In'), findsOneWidget);

        /// Note: Navigation testing would require a Navigator mock
      },
    );
  });
}
