import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Presentation%20Layer/Forms/user_login_form.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:lovelovelove/Theme/glass_widgets.dart';

/// Widget tests for the glassmorphism login page (LoginPageUp).
///
/// LoginPageUp builds its own LoginBloc from two context reads:
///   - SessionBLoc  (must be provided above)
///   - UserRepository (must be provided above)
/// Neither auto-login nor any network call happens at construction
/// time, so real instances are safe for render tests.

void main() {
  group('Login Page Widget Tests', () {
    late UserRepository userRepository;
    late SessionBLoc sessionBLoc;

    setUp(() {
      userRepository = UserRepository();
      sessionBLoc = SessionBLoc(userRepository: userRepository);
    });

    Widget buildTestHarness() {
      return RepositoryProvider<UserRepository>.value(
        value: userRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SessionBLoc>.value(value: sessionBLoc),
          ],
          child: const MaterialApp(home: LoginPageUp()),
        ),
      );
    }

    testWidgets('Login form displays email and password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());
      await tester.pumpAndSettle();

      // GlassInput wraps a plain TextField internally.
      expect(find.byType(TextField), findsNWidgets(2));
      // Labels may render twice (label text + field decoration), so
      // assert presence, not uniqueness.
      expect(find.text('Email'), findsAtLeastNWidgets(1));
      expect(find.text('Password'), findsAtLeastNWidgets(1));
    });

    testWidgets('Login form accepts valid input',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());
      await tester.pumpAndSettle();

      // GlassInput wraps a plain TextField internally; order matches
      // the form: email first, then password.
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), 'test@example.com');
      await tester.enterText(fields.at(1), 'password123');

      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('Sign In button is present', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());
      await tester.pumpAndSettle();

      // GlassButton renders its label as a Text widget.
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });
  });
}
