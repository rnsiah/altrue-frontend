part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChange extends LoginEvent {
  final String email;

 const LoginEmailChange(this.email);
}

class LoginPassWordChange extends LoginEvent {
  final String password;

 const LoginPassWordChange(this.password);
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginSubmitted { username: $email, password: $password }';
}

class LoginFailure extends LoginEvent {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure {error: $error }';
}
