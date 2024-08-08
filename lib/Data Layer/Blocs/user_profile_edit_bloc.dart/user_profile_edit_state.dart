import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import '../form_submission_status.dart';

class UserProfileEditState extends Equatable {
  User? user;
  String username;
  String dob;
  String title;
  String address;
  String country;
  String city;
  String zip;
  String? alrueDonorCode;
  XFile? profilePicture;

  final FormSubmissionStatus formStatus;

  UserProfileEditState(
      {this.user,
      this.profilePicture,
      this.address = '',
      this.username = '',
      this.city = '',
      this.country = '',
      this.dob = '',
      this.title = '',
      this.zip = '',
      this.alrueDonorCode = '',
      this.formStatus = const InitialFormStatus()});

  UserProfileEditState copyWith({
    User? user,
    String? username,
    String? dob,
    String? title,
    String? address,
    String? country,
    String? city,
    String? zip,
    String? altrueDonorCode,
    FormSubmissionStatus? formStatus,
    XFile? profilePicture,
  }) {
    return UserProfileEditState(
        user: user ?? this.user,
        profilePicture: profilePicture ?? this.profilePicture,
        username: username ?? this.username,
        formStatus: formStatus!,
        dob: dob ?? this.dob,
        alrueDonorCode: alrueDonorCode,
        title: title ?? this.title,
        address: address ?? this.address,
        city: city ?? this.city,
        country: country ?? this.country,
        zip: zip ?? this.zip);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [user, username, profilePicture, dob, alrueDonorCode, country, city, zip];
}
