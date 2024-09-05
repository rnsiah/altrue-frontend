import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_state.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class UserProfileComplete extends StatefulWidget {
  final User user;
  String userId;

  UserProfileComplete({
    Key? key,
    required this.user,
    required this.userId,
  }) : super(key: key);

  @override
  State<UserProfileComplete> createState() => _UserProfileCompleteState();
}

class _UserProfileCompleteState extends State<UserProfileComplete> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 0.0, // Remove default title spacing
        leading: IconButton(
          padding: const EdgeInsets.only(left: 16.0),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.amber),
        ),
        title: Center(
          child: Image.asset(
            'images/Altrue Logo White.png',
            width: 150, // Adjust image width for better fit
          ),
        ),
      ),
      body: BlocProvider<UserProfileEditBloc>(
        create: (context) =>
            UserProfileEditBloc(sessionBLoc: context.read<SessionBLoc>()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome To Altrue Global',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Complete Your Altrue Profile ${widget.user.email}',
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 32.0),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: _profileForm(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileForm() {
    final _usernameController = TextEditingController();
    final _addressController = TextEditingController();
    final _zipController = TextEditingController();
    final _dobController = TextEditingController();
    final _cityController = TextEditingController();

    return BlocListener<UserProfileEditBloc, UserProfileEditState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFaiiled) {
          _showSnackbar(context, formStatus.exception.toString());
        }
      },
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: _username(_usernameController),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: _addressStreet(_addressController),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: _city(_cityController),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: _zipCode(_zipController),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: _country(),
              // ),
              // _genderPicker(),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: _birthday(_dobController),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: _profilePicturePicker(),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: _donorCode(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: _confirmProfile(),
              ),
            ],
          )),
    );
  }

  Widget _city(TextEditingController controller) {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return Row(
          children: [
            Flexible(
              flex: 2,
              child: TextFormField(
                controller: controller,
                style: const TextStyle(color: Colors.amber),
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'City',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
                onChanged: (value) => context
                    .read<UserProfileEditBloc>()
                    .add(UserProfileCityChange(city: value)),
                validator: (value) =>
                    value!.length > 3 ? null : "Select A Valid Ciy",
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
                builder: (context, state) {
                  return TextFormField(
                    style: const TextStyle(color: Colors.amber),
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Enter Zip',
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.amber)),
                    onChanged: (value) {
                      print(value);
                      context
                          .read<UserProfileEditBloc>()
                          .add(UserProfileZipChange(zip: value));
                      print('the zip is: ${state.zip ?? ''}'); // Use
                    },
                    validator: (value) => value!.length == 5
                        ? null
                        : 'Please enter a valid zip code',
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget _username(TextEditingController controller) {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              labelText: 'Choose Altrue Username',
              labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
          // validator: (value) =>
          //     value!.length < 3 ? 'PLease enter a valid username' : null,
          onChanged: (value) => context
              .read<UserProfileEditBloc>()
              .add(UserProfileUsernameChange(username: value)),
        );
      },
    );
  }

  Widget _addressStreet(TextEditingController controller) {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Enter Street Address',
              labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
          onChanged: (value) => context
              .read<UserProfileEditBloc>()
              .add(UserProfileAddressChange(address: value)),
          validator: (value) =>
              value!.length > 10 ? null : 'Please choose a valid address',
        );
      },
    );
  }

  // Widget _country() {
  //   return
  // }

  // Widget _zipCode(TextEditingController controller) {
  //   return
  // }

  Widget _birthday(TextEditingController controller) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
            builder: (context, state) {
              return TextFormField(
                controller: controller,
                style: const TextStyle(color: Colors.amber),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Enter Birthday',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
                onChanged: (value) => context
                    .read<UserProfileEditBloc>()
                    .add(UserProfileDobChange(dob: value)),
                validator: (value) => validateBirthday(value),
              );
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 1,
          child: BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    'Choose Country',
                    style: TextStyle(color: Colors.amber),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white)),
                      child: CountryCodePicker(
                          onInit: (value) {
                            context.read<UserProfileEditBloc>().add(
                                UserProfileCountryChange(
                                    country: value!.name!));
                          },
                          showOnlyCountryWhenClosed: true,
                          textStyle:
                              const TextStyle(color: Colors.amber, fontSize: 9),
                          favorite: const ['US'],
                          initialSelection: 'US',
                          searchStyle: const TextStyle(),
                          showCountryOnly: true,
                          onChanged: (value) {
                            final countryName =
                                value.name; // Store the value in a variable

                            if (countryName != null) {
                              context.read<UserProfileEditBloc>().add(
                                  UserProfileCountryChange(
                                      country: countryName));
                              print(state.country);
                            } else {
                              // Handle the case where value.name is null (optional)
                              print('Country name is null!');
                            }
                          }),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Widget _profilePicturePicker() {
    XFile picture;
    final ImagePicker picker = ImagePicker();
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return MaterialButton(
          color: Colors.black,
          child: const Text(
            'Choose Profile Picture',
            style: TextStyle(color: Colors.amber),
          ),
          onPressed: () async {
            final XFile? profilePicture =
                await picker.pickImage(source: ImageSource.gallery);
            picture = profilePicture!;
            // ignore: use_build_context_synchronously
            context
                .read<UserProfileEditBloc>()
                .add(UserProfilePictureEdit(profilePicture: profilePicture));
          },
        );
      },
    );
  }

  Widget _donorCode() {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text(
              'I have an Altrue Donor Code',
              style: TextStyle(color: Colors.amber),
            ),
            const SizedBox(height: 7),
            TextFormField(
              style: const TextStyle(color: Colors.amber),
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(color: Colors.white)),
                  labelText: 'Altrue Donor Code',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
              onChanged: (value) {
                print(value);
                context
                    .read<UserProfileEditBloc>()
                    .add(UserDonorCodeChanged(altrueDonorCode: value));
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return null; // No validation if empty
                }
                if (value!.length != 17 || !value.startsWith('altrue')) {
                  return 'Please enter a valid donor code (format: altrueXXXXXXX)';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _confirmProfile() {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .07,
                  width: MediaQuery.of(context).size.width * .8,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber)),
                    child: const Text(
                      'Create Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<UserProfileEditBloc>()
                            .add(UserProfileCompleted());
                      } else {
                        context
                            .read<UserProfileEditBloc>()
                            .add(UserProfileEditFailure(error: "Exception"));
                      }
                    },
                  ),
                ),
              );
      },
    );
  }
}

enum Gender { He, She, They }

String? validateBirthday(String? birthdayString) {
  if (birthdayString == null || birthdayString.isEmpty) {
    return 'Please enter your birthday.';
  }

  try {
    // Split the string into day, month, and year components
    final List<int> birthdayComponents =
        birthdayString.split('-').map(int.parse).toList();
    final day = birthdayComponents[0];
    final month = birthdayComponents[1];
    final year = birthdayComponents[2];

    // Check for valid date format
    if (!isValidDate(day, month, year)) {
      return 'Invalid date format. Please use DD-MM-YYYY.';
    }

    // Check for valid age (at least 9 years old)
    final today = DateTime.now();
    final birthDate = DateTime(year, month, day);
    final ageDifference = today.difference(birthDate).inDays ~/ 365;
    if (ageDifference < 9) {
      return 'You must be at least 9 years old to create a profile.';
    }

    // Birthday format is valid and user is old enough
    return null;
  } on FormatException catch (e) {
    // Handle potential conversion errors (e.g., invalid characters)
    return 'Invalid birthday format. Please use DD-MM-YYYY.';
  }
}

bool isValidDate(int day, int month, int year) {
  return (1 <= day && day <= 31) &&
      (1 <= month && month <= 12) &&
      (year >= 1900); // You can adjust the minimum year as needed
}
