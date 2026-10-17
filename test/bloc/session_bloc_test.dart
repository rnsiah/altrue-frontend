import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_event_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:lovelovelove/Data%20Layer/Local%20Storage/user_data_access_object.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUserDao extends Mock implements UserDao {}

void main() {
  group('SessionBLoc', () {
    late MockUserRepository userRepository;
    late MockUserDao userDao;

    User user({int altid = 7, int hasProfile = 1}) => User(
          id: 1,
          key: 'tok',
          email: 'test@example.com',
          altid: altid,
          hasProfile: hasProfile,
        );

    Profile stubProfile() =>
        Profile(1, false, false, false, false)..username = 'testuser';

    setUpAll(() {
      registerFallbackValue(user());
    });

    setUp(() {
      userRepository = MockUserRepository();
      userDao = MockUserDao();
      when(() => userRepository.userDao).thenReturn(userDao);
      when(() => userRepository.deleteToken(localid: any(named: 'localid')))
          .thenAnswer((_) async {});
      when(() => userDao.clearCart()).thenAnswer((_) async {});
    });

    blocTest<SessionBLoc, SessionState>(
      'LoggedIn with altid==0 fetches the updated user before checking '
      'profile completeness, then emits Authenticated if profile is '
      'incomplete (checkIfProfileComplete == 0)',
      build: () {
        when(() => userRepository.getUpdatedUserFromApi(any()))
            .thenAnswer((_) async => user());
        when(() => userDao.checkIfProfileComplete(any())).thenAnswer(
            (_) async => 0);
        return SessionBLoc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(LoggedIn(
          user: User(
              id: 1, key: 'tok', email: 't@e.com', altid: 0, hasProfile: 1))),
      expect: () => [
        isA<Authenticated>()
            .having((s) => s.user.altid, 'user.altid', 7),
      ],
      verify: (_) {
        verify(() => userRepository.getUpdatedUserFromApi(any())).called(1);
        verifyNever(() => userRepository.getProfileFromApi(user: any(named: 'user')));
      },
    );

    blocTest<SessionBLoc, SessionState>(
      'LoggedIn with complete profile emits AuthenticatedWithProfile',
      build: () {
        when(() => userDao.checkIfProfileComplete(any()))
            .thenAnswer((_) async => 1);
        when(() => userRepository.getProfileFromApi(user: any(named: 'user')))
            .thenAnswer((_) async => stubProfile());
        return SessionBLoc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(LoggedIn(user: user())),
      expect: () => [
        isA<AuthenticatedWithProfile>().having(
            (s) => s.status, 'status', ProfileComplete.complete),
      ],
      verify: (_) {
        verify(() => userRepository.getProfileFromApi(user: any(named: 'user')))
            .called(1);
      },
    );

    blocTest<SessionBLoc, SessionState>(
      'LoggedIn survives an updated-user fetch failure (altid==0 path) '
      'and continues with the original user',
      build: () {
        when(() => userRepository.getUpdatedUserFromApi(any()))
            .thenThrow(Exception('network down'));
        when(() => userDao.checkIfProfileComplete(any()))
            .thenAnswer((_) async => 0);
        return SessionBLoc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(LoggedIn(
          user: User(
              id: 1, key: 'tok', email: 't@e.com', altid: null, hasProfile: 1))),
      expect: () => [
        // Original user keeps altid == null; Authenticated still emitted.
        isA<Authenticated>(),
      ],
    );

    blocTest<SessionBLoc, SessionState>(
      'LoggedOut emits Unauthenticated and clears the local token',
      build: () => SessionBLoc(userRepository: userRepository),
      act: (bloc) => bloc.add(LoggedOut()),
      expect: () => [isA<Unauthenticated>()],
      verify: (_) {
        verify(() => userRepository.deleteToken(localid: 0)).called(1);
        verify(() => userRepository.userDao).called(greaterThan(0));
      },
    );
  });
}
