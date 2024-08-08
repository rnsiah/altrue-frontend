import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';

class Login2State {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  Login2State(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  Login2State copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return Login2State(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
