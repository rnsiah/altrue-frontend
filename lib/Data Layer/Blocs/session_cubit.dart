import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_event_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class SessionBLoc extends Bloc<SessionEvent, SessionState> {
  final UserRepository userRepository;

  SessionBLoc({
    required this.userRepository,
  }) : super(UnknownSessionState()) {
    on<Apploaded>(_attemptAutoLogin);
    // on<Apploaded>(_mapAppLoadedToState);
    on<LoggedIn>(_mapUserLoggedInToState);
    on<LoggedOut>(_mapUserLoggedOutToState);
    // attemptAutoLogin();
  }

  Future<void> _mapUserLoggedOutToState(
      LoggedOut event, Emitter<SessionState> emit) async {
    signOut(emit);
  }

  Future<void> _mapUserLoggedInToState(
      LoggedIn event, Emitter<SessionState> emit) async {
    final profileCheck =
        await userRepository.userDao.checkIfProfileComplete(event.user.altid!);

    if (profileCheck == 0) {
      emit(Authenticated(user: event.user));
    }
    Profile profile = await userRepository.getProfileFromApi(user: event.user);
    emit(AuthenticatedWithProfile(
        profile: profile,
        user: event.user,
        status: ProfileComplete.incomplete));
  }

  // void _attemptAutoLogin(Apploaded event, Emitter<SessionState>emit)async{

  // }

  void _attemptAutoLogin(Apploaded event, Emitter<SessionState> emit) async {
    print('running autologin');
    final sessionOpen = await userRepository.hasToken();

    if (sessionOpen == true) {
      print('user logged in on this phone before');
      User? user = await userRepository.userDao.getCurrentUser(0);
      final hasProfileInBackend =
          await userRepository.checkProfileComplete(user!);
      print(hasProfileInBackend);
      if (user != null && hasProfileInBackend == true && user.hasProfile == 0) {
        userRepository.userDao.updateUser(user);
        await userRepository.getUpdatedUserFromApi(user);
        Profile profile = await userRepository.getProfileFromApi(user: user);
        emit(AuthenticatedWithProfile(
            profile: profile, status: ProfileComplete.complete, user: user));
      } else if (hasProfileInBackend == true && user.hasProfile == 1) {
        await userRepository.getUpdatedUserFromApi(user);
        Profile profile = await userRepository.getProfileFromApi(user: user);
        emit(AuthenticatedWithProfile(
            profile: profile, user: user, status: ProfileComplete.complete));
      } else {
        emit(Authenticated(user: user));
      }
    }
    if (sessionOpen == false) {
      showAuthProcess();
    }
  }

  void logInUser({required User user}) {
    user = User(
        altid: user.altid,
        email: user.email,
        key: user.key,
        hasProfile: 0,
        id: user.id);
  }

  void showProfileComplete(User user) => emit(Authenticated(user: user));

  void showAuthProcess() {
    emit(Unauthenticated());
  }

  void showSession(
    User loggedInUser,
  ) async {
    User loggedinUser = User(
        hasProfile: loggedInUser.hasProfile,
        id: loggedInUser.id,
        email: loggedInUser.email,
        altid: loggedInUser.altid,
        key: loggedInUser.key);
    emit(Authenticated(user: loggedinUser));
  }

  void signOut(Emitter<SessionState> emit) {
    userRepository.userDao.clearCart();
    userRepository.deleteToken(localid: 0);
    emit(Unauthenticated());
  }

  // Stream<SessionState> mapEventToState(SessionEvent event) async* {
  //   if (event is Apploaded) {
  //     yield* _mapAppLoadedToState(event);
  //   }
  //   if (event is LoggedIn) {
  //     yield* _mapUserLoggedInToState(event);
  //   }
  //   if (event is LoggedOut) {
  //     _mapUserLoggedOutToState(event);
  //   }
  //   if (event is ProfileBeingCompleted) {
  //     yield* _mapUserProfileEditToState(event);
  //   }
  // }

  void _mapUserProfileEditToState(
      Emitter<SessionState> emit, ProfileBeingCompleted event) {
    emit(Authenticated(user: event.user));
  }

  Future<void> _mapAppLoadedToState(
      Apploaded event, Emitter<SessionState> emit) async {
    emit(AuthtLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 70));
      final currentUser = await userRepository.userDao.getCurrentUser(0);
      if (currentUser != null && currentUser.hasProfile == 1) {
        Profile profile =
            await userRepository.getProfileFromApi(user: currentUser);
        emit(AuthenticatedWithProfile(
            profile: profile,
            user: currentUser,
            status: ProfileComplete.complete));
      } else if (currentUser != null && currentUser.hasProfile == 0) {
        emit(Authenticated(user: currentUser));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  // Stream<SessionState> _mapAppLoadedToState(Apploaded event) async* {
  //   yield AuthtLoading();
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 700));
  //     final currentUser = await userRepository.userDao.getCurrentUser(0);
  //     if (currentUser != null && currentUser.hasProfile == 1) {
  //       Profile profile =
  //           await userRepository.getProfileFromApi(user: currentUser);

  //       yield AuthenticatedWithProfile(
  //           profile: profile,
  //           user: currentUser,
  //           status: ProfileComplete.complete);
  //     } else if (currentUser != null && currentUser.hasProfile == 0) {
  //       yield Authenticated(
  //         user: currentUser,
  //       );
  //     } else {
  //       yield Unauthenticated();
  //     }
  //   } catch (e) {
  //     yield AuthFailure(message: e.toString());
  //   }
}
