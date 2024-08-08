abstract class ConfirmationEvent {}

class ConfirmationCodeChanged extends ConfirmationEvent {
  final String code;

  ConfirmationCodeChanged(this.code);
}

class ConfirmationSubmitted extends ConfirmationEvent {
  final String code;
  final String email;

  ConfirmationSubmitted({required this.code, required this.email});
}
