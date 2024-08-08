import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_event.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

enum ValidationState {
  intro,
  login,
  signup,
  confirmSignUp,
  signUpWithOutConfirmation,
  userProfileIncomplete,
}

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit(
      {required this.sessionBloc,
      required this.userRepository,
      required this.userProfileEditBloc})
      : super(ValidationState.intro);

  UserRepository userRepository;
  SessionBLoc sessionBloc;
  UserProfileEditBloc userProfileEditBloc;

  ValidationCredentials? credentials;
  User? user;

  void showIntro() => emit(ValidationState.intro);
  void showLogin() => emit(ValidationState.login);
  void showSignUp() => emit(ValidationState.signup);

  void showConfirmSignUp(
      {required String email, required String password, String? id}) {
    credentials =
        ValidationCredentials(email: email, password: password, id: 0);

    emit(ValidationState.confirmSignUp);
  }

  void logIn(User user) => sessionBloc.logInUser(user: user);

  void showUserProfileCompletion(User user) async {
    userProfileEditBloc.add(UserProfileBegin(user: user));
    sessionBloc.showProfileComplete(user);
  }

  void launchSession(User user) => sessionBloc.showSession(user);
}

class ValidationCredentials {
  final String email;
  final String? password;
  final int? id;

  ValidationCredentials({required this.email, this.password, this.id = 0});
}
