import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

abstract class SessionEvent extends Equatable {}

class ProfileBeingCompleted extends SessionEvent {
  final User user;
  final ProfileCompletion profileCompletion;

  ProfileBeingCompleted(
    this.user,
    this.profileCompletion,
  );
  @override
  List<Object> get props => [user, profileCompletion];
}

class Apploaded extends SessionEvent {
  @override
  List<Object?> get props => [];
}

class LoggedIn extends SessionEvent {
  final User user;

  LoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class LoggedOut extends SessionEvent {
  @override
  List<Object?> get props => [];
}
