import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_event_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockSessionBLoc extends Mock implements SessionBLoc {}

void main() {
  group('LoginBloc', () {
    late MockUserRepository userRepository;
    late MockSessionBLoc sessionBLoc;

    /// Matches the shape UserRepository.authenticate() returns on success
    /// (key + altid are what SessionBLoc.add(LoggedIn(user)) consumes).
    final successUser = User(
      id: 1,
      key: 'tok_test',
      email: 'test@example.com',
      altid: 1,
      hasProfile: 1,
    );

    setUpAll(() {
      // any() inside verify() needs a fallback registered for SessionEvent.
      registerFallbackValue(LoggedIn(
          user: User(
              id: 0, key: '', email: '', altid: 0, hasProfile: 0)));
    });

    setUp(() {
      userRepository = MockUserRepository();
      sessionBLoc = MockSessionBLoc();
    });

    blocTest<LoginBloc, LoginState>(
      'email change updates state email',
      build: () => LoginBloc(
          userRepository: userRepository, sessionBLoc: sessionBLoc),
      act: (bloc) => bloc.add(const LoginEmailChange('test@example.com')),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.email, 'email', 'test@example.com'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'password change updates state password',
      build: () => LoginBloc(
          userRepository: userRepository, sessionBLoc: sessionBLoc),
      act: (bloc) => bloc.add(const LoginPassWordChange('secret123')),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.password, 'password', 'secret123'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'submit with valid credentials emits submitting then success, '
      'and forwards LoggedIn to the session bloc',
      build: () {
        when(() => userRepository.authenticate(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => successUser);
        return LoginBloc(
            userRepository: userRepository, sessionBLoc: sessionBLoc);
      },
      act: (bloc) => bloc.add(
          const LoginSubmitted(email: 'test@example.com', password: 'secret123')),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.formStatus, 'formStatus', isA<FormSubmitting>()),
        isA<LoginState>()
            .having((s) => s.formStatus, 'formStatus', isA<SubmissionSuccess>()),
      ],
      verify: (_) {
        verify(() => sessionBLoc.add(any(that: isA<LoggedIn>()))).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'submit with rejected credentials emits submitting then failure '
      'and never touches the session bloc',
      build: () {
        when(() => userRepository.authenticate(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(Exception('invalid credentials'));
        return LoginBloc(
            userRepository: userRepository, sessionBLoc: sessionBLoc);
      },
      act: (bloc) => bloc.add(
          const LoginSubmitted(email: 'test@example.com', password: 'nope')),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.formStatus, 'formStatus', isA<FormSubmitting>()),
        isA<LoginState>().having(
            (s) => s.formStatus, 'formStatus', isA<SubmissionFailed>()),
      ],
      verify: (_) {
        verifyNever(() => sessionBLoc.add(any()));
      },
    );

    blocTest<LoginBloc, LoginState>(
      'email validator: valid email passes',
      build: () => LoginBloc(
          userRepository: userRepository, sessionBLoc: sessionBLoc),
      act: (bloc) => bloc.add(const LoginEmailChange('user@host.com')),
      expect: () => [
        isA<LoginState>().having((s) => s.isValidemail, 'isValidemail', true),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'email validator: too-short email fails isValidemail',
      build: () => LoginBloc(
          userRepository: userRepository, sessionBLoc: sessionBLoc),
      act: (bloc) => bloc.add(const LoginEmailChange('a@b')),
      expect: () => [
        isA<LoginState>().having((s) => s.isValidemail, 'isValidemail', false),
      ],
    );
  });
}
