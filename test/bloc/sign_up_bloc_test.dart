import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

/// Real ValidationCubit with mocked-out dependencies, so we can verify
/// that a successful signup routes the user into profile completion.
class MockSessionBLoc extends Mock implements SessionBLoc {}

class MockUserProfileEditBloc extends Mock implements UserProfileEditBloc {}

void main() {
  group('SignUpBloc', () {
    late MockUserRepository userRepository;
    late MockSessionBLoc sessionBLoc;
    late ValidationCubit validationCubit;

    final successUser = User(
      id: 1,
      key: 'tok_test',
      email: 'test@example.com',
      altid: 1,
      hasProfile: 0,
    );

    setUpAll(() {
      registerFallbackValue(successUser);
    });

    setUp(() {
      userRepository = MockUserRepository();
      sessionBLoc = MockSessionBLoc();
      validationCubit = ValidationCubit(
        sessionBloc: sessionBLoc,
        userRepository: userRepository,
        userProfileEditBloc: MockUserProfileEditBloc(),
      );
    });

    tearDown(() {
      validationCubit.close();
    });

    SignUpBloc buildBloc() =>
        SignUpBloc(userRepository: userRepository, validationCubit: validationCubit);

    blocTest<SignUpBloc, SignUpState>(
      'email change updates state email',
      build: buildBloc,
      act: (bloc) => bloc.add(SignUpEmailChanged(email: 'new@example.com')),
      expect: () => [
        isA<SignUpState>().having((s) => s.email, 'email', 'new@example.com'),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'password changes update state and password-match helper reflects them',
      build: buildBloc,
      act: (bloc) async => bloc
        ..add(SignUpPassword1Changed(password1: 'secret123'))
        ..add(SignUpPassword2Changed(password2: 'secret123')),
      expect: () => [
        // After the first change: p2 still empty -> no match yet.
        isA<SignUpState>()
            .having((s) => s.password1, 'password1', 'secret123')
            .having((s) => s.validatePW(s.password1, s.password2),
                'passwordsMatch', false),
        isA<SignUpState>()
            .having((s) => s.password1, 'password1', 'secret123')
            .having((s) => s.validatePW(s.password1, s.password2),
                'passwordsMatch', true),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'mismatched passwords fail the match helper',
      build: buildBloc,
      act: (bloc) async => bloc
        ..add(SignUpPassword1Changed(password1: 'secret123'))
        ..add(SignUpPassword2Changed(password2: 'different')),
      expect: () => [
        isA<SignUpState>().having(
            (s) => s.validatePW(s.password1, s.password2),
            'passwordsMatch', false),
        isA<SignUpState>().having(
            (s) => s.validatePW(s.password1, s.password2),
            'passwordsMatch', false),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'altrue code checkbox toggle updates state',
      build: buildBloc,
      act: (bloc) => bloc.add(SignUpAltrueCodeCheckboxChanged(hasAltrueCode: true)),
      expect: () => [
        isA<SignUpState>().having((s) => s.hasAltrueCode, 'hasAltrueCode', true),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'altrue code entry updates state',
      build: buildBloc,
      act: (bloc) => bloc.add(SignUpAltrueCodeChanged(altrueCode: 'GOLD24')),
      expect: () => [
        isA<SignUpState>().having((s) => s.altrueCode, 'altrueCode', 'GOLD24'),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'successful registration emits submitting then success and '
      'routes into profile completion via ValidationCubit',
      build: () {
        when(() => userRepository.register(
              email: any(named: 'email'),
              password1: any(named: 'password1'),
              password2: any(named: 'password2'),
            )).thenAnswer((_) async => successUser);
        return buildBloc();
      },
      act: (bloc) => bloc.add(SignUpSubmittedWithoutConfirmaation(
          email: 'test@example.com', password1: 'secret123', password2: 'secret123')),
      expect: () => [
        isA<SignUpState>()
            .having((s) => s.formStatus, 'formStatus', isA<FormSubmitting>()),
        isA<SignUpState>()
            .having((s) => s.formStatus, 'formStatus', isA<SubmissionSuccess>()),
      ],
      verify: (_) {
        // showUserProfileCompletion routes via sessionBloc.showProfileComplete.
        verify(() => sessionBLoc.showProfileComplete(any())).called(1);
      },
    );

    blocTest<SignUpBloc, SignUpState>(
      'rejected registration emits failure and skips profile completion',
      build: () {
        when(() => userRepository.register(
              email: any(named: 'email'),
              password1: any(named: 'password1'),
              password2: any(named: 'password2'),
            )).thenThrow(Exception('email taken'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(SignUpSubmittedWithoutConfirmaation(
          email: 'test@example.com', password1: 'secret123', password2: 'secret123')),
      expect: () => [
        isA<SignUpState>()
            .having((s) => s.formStatus, 'formStatus', isA<FormSubmitting>()),
        isA<SignUpState>()
            .having((s) => s.formStatus, 'formStatus', isA<SubmissionFailed>()),
      ],
      verify: (_) {
        verifyNever(() => sessionBLoc.showProfileComplete(any()));
      },
    );
  });
}
