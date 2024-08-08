import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

enum ProfileComplete { incomplete, complete }

class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class AuthtLoading extends SessionState {}

class AuthenticatedWithProfile extends SessionState {
  User user;
  ProfileComplete status;
  Profile profile;

  AuthenticatedWithProfile(
      {required this.profile, required this.user, required this.status});
}

class Authenticated extends SessionState {
  final User user;
  final ProfileComplete status = ProfileComplete.incomplete;

  Authenticated({required this.user});
}

class AuthFailure extends SessionState {
  final String message;
  AuthFailure({required this.message});
}
