import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';

class ConfirmationState {
  final String code;
  final String email;

  bool get isValidCode => code.length == 6;
  final FormSubmissionStatus formStatus;

  ConfirmationState(
      {this.email = '',
      this.code = '',
      this.formStatus = const InitialFormStatus()});

  ConfirmationState copyWith(
      {String? code, FormSubmissionStatus? formStatus, String? email}) {
    return ConfirmationState(
        email: email ?? this.email,
        code: code ?? this.code,
        formStatus: formStatus ?? this.formStatus);
  }
}
