import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_state.dart';
import 'package:lovelovelove/Data%20Layer/Local%20Storage/user_data_access_object.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/UserProfile_Transaction_Details/userprofile_details_tabs.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';

import '../Widgets/company_dashboard/water_view.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;

  const ProfileScreen({super.key, required this.profile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(fit: StackFit.expand, children: [
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.white, Colors.amber],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
        )),
      ),
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Image(
            image: AssetImage('images/Altrue Logo White.png'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      foregroundImage:
                          NetworkImage(widget.profile.profilePicture!.url),
                      backgroundImage:
                          NetworkImage(widget.profile.profilePicture!.url),
                    ),
                    const SizedBox(width: 22),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.profile.username.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          const Text('Username',
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 12)),
                          const SizedBox(
                            height: 12,
                          ),
                          MaterialButton(
                            minWidth: 10,
                            color: Colors.transparent,
                            child: const Text(
                              'Edit Profile',
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 10),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pushNamed('/editmyprofile',
                                  arguments: widget.profile);
                            },
                          )
                        ]),
                    const Text(
                      'My\nProfile',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.amber),
                    ),
                  ],
                ),
                TabBar(
                    indicatorColor: Colors.amber,
                    controller: _controller,
                    tabs: const [
                      Tab(
                        text: 'Altrue Stats',
                      ),
                      Tab(
                        text: 'Donations',
                      ),
                      Tab(text: 'Rewards')
                    ]),
                SizedBox.fromSize(
                  size:
                      Size.fromHeight(MediaQuery.of(context).size.height * .7),
                  child: TabBarView(controller: _controller, children: [
                    AltrueStats(widget: widget),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .5,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12.0, bottom: 12),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Recent Donations',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.amber, fontSize: 20),
                              ),
                            ),
                          ),
                          widget.profile.userdonations!.isNotEmpty
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 400,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.profile.userdonations!.length,
                                      itemBuilder: (context, index) {
                                        if (widget.profile.userdonations![index]
                                                .nonprofit !=
                                            null) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onLongPress: () {
                                                    showDialog(
                                                        context: (context),
                                                        builder: (_) {
                                                          return Dialog(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            60)),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .4,
                                                                child:
                                                                    const Text(
                                                                        'hey')),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadiusDirectional
                                                                .circular(14),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                widget
                                                                    .profile
                                                                    .userdonations![
                                                                        index]
                                                                    .nonprofit!
                                                                    .logo!)),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      )),
                                                ),
                                              )
                                            ],
                                          );
                                        } else if (widget
                                                .profile
                                                .userdonations![index]
                                                .atrocity !=
                                            null) {
                                          return Column(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color:
                                                            Colors.amberAccent,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        widget
                                                            .profile
                                                            .userdonations![
                                                                index]
                                                            .atrocity!
                                                            .title,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            backgroundColor:
                                                                Colors.black38),
                                                      ))))
                                            ],
                                          );
                                        } else if (widget
                                                .profile
                                                .userdonations![index]
                                                .project !=
                                            null) {
                                          return Column(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                          child: Text(widget
                                                              .profile
                                                              .userdonations![
                                                                  index]
                                                              .project!
                                                              .title
                                                              .toString()))))
                                            ],
                                          );
                                        }
                                        return Container(
                                          child: Text(
                                            widget.profile.userdonations![index]
                                                .id
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        );
                                      }),

                                  // Column(
                                  //       children: [
                                  //         profile.userdonations![index].nonprofit !=
                                  //                 null
                                  //  Container(
                                  //     height: 100,
                                  //     width: 100,
                                  //     decoration: BoxDecoration(
                                  //       image: DecorationImage(
                                  //           image: NetworkImage(profile
                                  //               .userdonations![index]
                                  //               .nonprofit!
                                  //               .logo)),
                                  //       shape: BoxShape.circle,
                                  //     ))
                                  //             :profile.userdonations![index].atrocity!=null?

                                  //             Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 6.0, right: 6),
                                  //                 child: Container(
                                  //                   height: 100,
                                  //                   width: 100,
                                  //                   decoration: BoxDecoration(
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(14),
                                  //                     color: Colors.red,
                                  //                   ),
                                  //                   child: Center(
                                  //                       child: profile
                                  //                                   .userdonations![
                                  //                                       index]
                                  //                                   .atrocity !=
                                  //                               null
                                  //                           ? Text(
                                  //                               profile
                                  //                                   .userdonations![
                                  //                                       index]
                                  //                                   .atrocity!
                                  //                                   .title,
                                  //                               softWrap: true,
                                  //                             )
                                  //                           : Text(profile
                                  //                               .userdonations![index]
                                  //                               .project!
                                  //                               .title)),
                                  //                 ),
                                  //               ),
                                  //         profile.userdonations![index].nonprofit !=
                                  //                 null
                                  //             ? Text(profile.userdonations![index]
                                  //                 .nonprofit!.name)
                                  //             : Text('The Atrocity')
                                  //       ],
                                  //     )),
                                  // itemBuilder: (context, index) => Column(
                                  //       children: [
                                  //         Container(
                                  //             decoration:
                                  //                 profile.userdonations![index].nonprofit !=
                                  //                         null
                                  //                     ? BoxDecoration(
                                  //                         image: DecorationImage(
                                  //                             image: NetworkImage(profile
                                  //                                 .userdonations![index]
                                  //                                 .nonprofit!
                                  //                                 .logo)),
                                  //                         shape: BoxShape.circle)
                                  //                     : BoxDecoration(color: Colors.black),
                                  //             child:
                                  //                 profile.userdonations![index].nonprofit !=
                                  //                         null
                                  //                     ? null
                                  //                     : Text('Altrue Cause')),
                                  //         profile.userdonations![index].nonprofit != null
                                  //             ? Text(profile
                                  //                 .userdonations![index].nonprofit!.name)
                                  //             : Text(profile
                                  //                 .userdonations![index].atrocity!.title)
                                  //       ],
                                  //     )),
                                )
                              : Container(
                                  child: const Text(
                                      "You have not made any donations to any organizations."),
                                ),
                        ]),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.33,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: innerHeight * .72,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              widget.profile.username!,
                                              style: const TextStyle(
                                                color: Colors.amber,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Orders',
                                                    ),
                                                    Text(widget
                                                        .profile.orders!.length
                                                        .toString()),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 8),
                                              child: Container(
                                                height: 50,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: const [
                                                Text('Pending'),
                                                Text('1')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: height * .5,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'My Transactions',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: UserProfileDetailTabs(
                                            profile: widget.profile))
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget _profileForm() {
    return Form(
        child: Column(
      children: [
        _username(),
        _addressStreet(),
        // _confirmProfile()
      ],
    ));
  }
}

class AltrueStats extends StatelessWidget {
  const AltrueStats({
    super.key,
    required this.widget,
  });

  final ProfileScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 15, left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Altrue Stats',
              style: TextStyle(color: Colors.amber, fontSize: 20),
            ),
          ),
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return MediterranesnDietView(
              isProfileInfo: true,
              textColor: Colors.white,
              isCompanyInfo: false,
              profile: widget.profile,
              color: Colors.grey[900],
            );
          },
        ),
        WaterView(
          profile: widget.profile,
        )
      ]),
    ));
  }
}

Widget _city() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return TextFormField(
        style: const TextStyle(color: Colors.amber),
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber)),
            labelText: 'City',
            labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
        onChanged: (value) => context
            .read<UserProfileEditBloc>()
            .add(UserProfileCityChange(city: value)),
        validator: (value) =>
            state.city.length > 3 ? null : "Select A Valid Ciy",
      );
    },
  );
}

Widget _username() {
  return TextFormField(
    style: const TextStyle(color: Colors.amber),
    decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        labelText: 'Altrue Username',
        labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
    onChanged: (value) {},
  );
}

void _showSnackbar(BuildContext context, String message) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

// _confirmProfile() {
//   return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
//     builder: (context, state) {
//       return state.formStatus is FormSubmitting
//           ? CircularProgressIndicator()
//           : MaterialButton(
//               color: Colors.amber,
//               child: Text(
//                 'Create Profile',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onPressed: () {
//                 print([state.address, state.zip, state.country]);
//                 if (_formKey.currentState!.validate()) {
//                   context.read<UserProfileEditBloc>().add(
//                       UserProfileCompleted(
//                           profile: ProfileCompletion(
//                               address: state.address,
//                               city: state.city,
//                               dob: state.dob,
//                               country: state.country,
//                               zip: state.zip,
//                               title: state.title,
//                               username: state.username)));
//                 } else {
//                   context
//                       .read<UserProfileEditBloc>()
//                       .add(UserProfileEditFailure(error: "Exception"));
//                 }
//               },
//             );
//     },
//   );
// }

Widget _addressStreet() {
  return TextFormField(
      style: const TextStyle(color: Colors.amber),
      decoration: const InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          labelText: 'Street Address',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
      onChanged: (value) {});
}

Widget _country() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return CountryCodePicker(
          searchStyle: const TextStyle(),
          showCountryOnly: true,
          onChanged: (value) {
            print(value.toCountryStringOnly());
            context.read<UserProfileEditBloc>().add(
                UserProfileCountryChange(country: value.toCountryStringOnly()));
          });
    },
  );
}

Widget _zipCode() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return TextFormField(
        style: const TextStyle(color: Colors.amber),
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber)),
            labelText: 'Zip Code',
            labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
        onChanged: (value) => context
            .read<UserProfileEditBloc>()
            .add(UserProfileZipChange(zip: value)),
        validator: (value) =>
            state.zip.length == 5 ? null : 'Please enter a valid zip code',
      );
    },
  );
}

Widget _birthday() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return TextFormField(
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Birthday',
              labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
          onChanged: (value) => context
              .read<UserProfileEditBloc>()
              .add(UserProfileDobChange(dob: DateTime.now().toString())));
    },
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

// Widget _genderPicker() {
//   Gender? _gender = Gender.He;
//   return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
//     builder: (context, state) {
//       return Column(
//         children: [
//           RadioListTile(
//               activeColor: Colors.amber,
//               title: Text(
//                 'He',
//                 style: TextStyle(color: Colors.amber),
//               ),
//               value: Gender.He,
//               groupValue: _gender,
//               onChanged: (Gender? value) {
//                 _gender = value!;
//                 print(_gender.toString().split('.').last);
//                 context.read<UserProfileEditBloc>().add(
//                     UserProfileTitleChange(
//                         title: _gender.toString().split('.').last));
//               }),
//           RadioListTile(
//               activeColor: Colors.amber,
//               tileColor: Colors.black38,
//               title: Text(
//                 'She',
//                 style: TextStyle(color: Colors.amber),
//               ),
//               value: Gender.She,
//               groupValue: _gender,
//               onChanged: (Gender? value) {
//                 _gender = value;
//                 print(_gender.toString().split('.').last);
//                 context.read<UserProfileEditBloc>().add(
//                     UserProfileTitleChange(
//                         title: _gender.toString().split('.').last));
//               }),
//           RadioListTile(
//               activeColor: Colors.amber,
//               selectedTileColor: Colors.black12,
//               value: Gender.They,
//               title: Text('They', style: TextStyle(color: Colors.amber)),
//               groupValue: _gender,
//               onChanged: (Gender? value) {
//                 print(value.toString().split('.').last);
//                 _gender = value;
//                 context.read<UserProfileEditBloc>().add(
//                     UserProfileTitleChange(
//                         title: _gender.toString().split('.').last));
//               }),
//         ],
//       );
//     },
//   );
// }}
