import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_state.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class UserProfileEditBloc
    extends Bloc<UserProfileEditEvent, UserProfileEditState> {
  final UserRepository userRepository = UserRepository();
  final SessionBLoc sessionBLoc;

  UserProfileEditBloc({required this.sessionBLoc})
      : super(UserProfileEditState()) {
    on<UserDonorCodeChanged>(_userProfileDonorCodeChange);

    on<UserProfileAddressChange>(_userProfileAddressChange);
    on<UserProfileZipChange>(_userProfileZipChange);
    on<UserProfileCountryChange>(_userProfileCountryChange);
    on<UserProfileCityChange>(_userProfileCityChange);
    on<UserProfileDobChange>(_userProfileDobChange);
    on<UserProfileUsernameChange>(_userProfileUserNameChange);

    // on<UserProfilePictureEdit>((event, emit) =>
    //     emit(state.copyWith(profilePicture: event.profilePicture)));
    on<UserProfileCompleted>(_userProfileCompleted);
  }

  void _userProfileAddressChange(UserProfileAddressChange event,
      Emitter<UserProfileEditState> emit) async {
    UserProfileEditState newState = state;
    newState.address = event.address;
    emit(newState);
  }

  void _userProfileDobChange(
      UserProfileDobChange event, Emitter<UserProfileEditState> emit) async {
    UserProfileEditState newState = state;
    newState.dob = event.dob;
    emit(newState);
  }

  void _userProfileZipChange(
      UserProfileZipChange event, Emitter<UserProfileEditState> emit) async {
    UserProfileEditState newState = state;
    newState.zip = event.zip;
    emit(newState);
  }

  void _userProfileCityChange(
      UserProfileCityChange event, Emitter<UserProfileEditState> emit) async {
    UserProfileEditState newState = state;
    newState.city = event.city;
    emit(newState);
  }

  void _userProfileUserNameChange(UserProfileUsernameChange event,
      Emitter<UserProfileEditState> emit) async {
    UserProfileEditState newState = state;
    newState.username = event.username;
    emit(newState);
  }

  void _userProfileCountryChange(UserProfileCountryChange event,
      Emitter<UserProfileEditState> emit) async {
    UserProfileEditState newState = state;
    newState.country = event.country;

    emit(newState);
  }

  void _userProfileDonorCodeChange(
      UserDonorCodeChanged event, Emitter<UserProfileEditState> emit) async {
    UserProfileEditState newState = state;
    newState.alrueDonorCode = event.altrueDonorCode;
    emit(newState);
  }

  void _userProfileCompleted(
      UserProfileCompleted event, Emitter<UserProfileEditState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    User? user = await userRepository.userDao.getCurrentUser(0);
    ProfileCompletion profileComplete = ProfileCompletion(
        username: state.username,
        dob: state.dob,
        address: state.address,
        city: state.city,
        country: state.country,
        altrueDonorCode: state.alrueDonorCode,
        zip: state.zip);
    if (user != null) {
      try {
        await userRepository.updateProfile(
            user: user, profile: profileComplete);
        User updatedUser = await userRepository.getUpdatedUserFromApi(user);
        await userRepository.userDao.updateUser(updatedUser);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        Profile profile = await userRepository.getProfileFromApi(user: user);
        // ignore: invalid_use_of_visible_for_testing_member
        sessionBLoc.emit(AuthenticatedWithProfile(
            profile: profile, user: user, status: ProfileComplete.complete));
      } catch (e) {
        print(e);
        emit(state.copyWith(formStatus: SubmissionFaiiled('exception')));
      }
    } else {
      // ignore: invalid_use_of_visible_for_testing_member
      sessionBLoc.emit(Authenticated(user: user!));
    }
  }
}
