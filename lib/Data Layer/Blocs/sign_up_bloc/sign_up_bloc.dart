import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;
  final ValidationCubit validationCubit;

  SignUpBloc({required this.userRepository, required this.validationCubit})
      : super(SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPassword1Changed>(_onPassword1Changed);
    on<SignUpPassword2Changed>(_onPassword2Changed);
    on<SignUpAltrueCodeChanged>(_onAltrueCodeChanged);
    on<SignUpAltrueCodeCheckboxChanged>(_onAltrueCodeBoxChecked);
    on<SignUpSubmittedWithoutConfirmaation>(_onSubmitted);
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPassword1Changed(
      SignUpPassword1Changed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password1: event.password1));
  }

  void _onPassword2Changed(
      SignUpPassword2Changed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password2: event.password2));
  }

  void _onAltrueCodeBoxChecked(
      SignUpAltrueCodeCheckboxChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(hasAltrueCode: event.hasAltrueCode));
  }

  void _onAltrueCodeChanged(
      SignUpAltrueCodeChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(altrueCode: event.altrueCode));
  }

  Future<void> _onSubmitted(SignUpSubmittedWithoutConfirmaation event,
      Emitter<SignUpState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      final User user = await userRepository.register(
        email: event.email,
        password1: event.password1,
        password2: event.password2,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));
      validationCubit.showUserProfileCompletion(user);
    } catch (e) {
      emit(state.copyWith(
          formStatus: SubmissionFailed('Your Submission Failed')));
    }
  }
}
