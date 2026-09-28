import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';

class LoginState {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;
  bool get isValidemail => email.contains('@') && email.length > 5;

  LoginState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
