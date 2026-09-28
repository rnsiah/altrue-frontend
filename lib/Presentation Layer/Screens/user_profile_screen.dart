import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_state.dart';
import 'package:lovelovelove/Data%20Layer/Local%20Storage/user_data_access_object.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/UserProfile_Transaction_Details/userprofile_details_tabs.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/profile_recent_donations_tab.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ]
                : [
                    GlassmorphismTheme.textSecondary,
                    GlassmorphismTheme.textPrimary
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + GlassmorphismTheme.lg,
            bottom: GlassmorphismTheme.xl,
          ),
          child: Column(
            children: [
              // Profile Header Section
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: GlassmorphismTheme.md),
                child: GlassCard(
                  hasGoldBorder: true,
                  child: Padding(
                    padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                    child: Row(
                      children: [
                        // Profile Picture
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: GlassmorphismTheme.gold.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50.0,
                            foregroundImage: NetworkImage(
                                widget.profile.profilePicture!.url),
                            backgroundImage: NetworkImage(
                                widget.profile.profilePicture!.url),
                          ),
                        ),
                        const SizedBox(width: GlassmorphismTheme.lg),

                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.profile.username.toString(),
                                style: isDark
                                    ? GlassmorphismTheme.h2Style
                                    : GlassmorphismTheme.h2Style,
                              ),
                              Text(
                                'Username',
                                style: TextStyle(
                                  color:
                                      GlassmorphismTheme.gold.withOpacity(0.7),
                                  fontSize: GlassmorphismTheme.captionSize,
                                ),
                              ),
                              const SizedBox(height: GlassmorphismTheme.md),
                              GlassButton(
                                text: 'Edit Profile',
                                variant: GlassButtonVariant.secondary,
                                onPressed: () async {
                                  context.go('/userprofile/editmyprofile');
                                },
                                horizontalPadding: GlassmorphismTheme.md,
                                verticalPadding: GlassmorphismTheme.sm,
                              ),
                            ],
                          ),
                        ),

                        // My Profile Text
                        Column(
                          children: [
                            Text(
                              'My',
                              style: TextStyle(
                                fontSize: GlassmorphismTheme.h2Size,
                                color: GlassmorphismTheme.gold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: GlassmorphismTheme.h2Size,
                                color: GlassmorphismTheme.gold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: GlassmorphismTheme.lg),

              // Tab Bar
              GlassCard(
                margin: const EdgeInsets.symmetric(
                    horizontal: GlassmorphismTheme.md),
                child: TabBar(
                  indicator: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        GlassmorphismTheme.gold.withOpacity(0.8),
                        GlassmorphismTheme.goldDark.withOpacity(0.8),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(GlassmorphismTheme.radiusMd),
                  ),
                  indicatorColor: GlassmorphismTheme.gold,
                  controller: _controller,
                  tabs: [
                    Tab(
                      child: Text(
                        'Altrue Stats',
                        style: TextStyle(
                          color: isDark
                              ? GlassmorphismTheme.textPrimary
                              : GlassmorphismTheme.textPrimary,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Donations',
                        style: TextStyle(
                          color: isDark
                              ? GlassmorphismTheme.textPrimary
                              : GlassmorphismTheme.textPrimary,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Rewards',
                        style: TextStyle(
                          color: isDark
                              ? GlassmorphismTheme.textPrimary
                              : GlassmorphismTheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: GlassmorphismTheme.md),

              // Tab Content
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    // Altrue Stats Tab
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GlassmorphismTheme.md),
                      child: GlassCard(
                        child: Padding(
                          padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                          child: AltrueStats(widget: widget),
                        ),
                      ),
                    ),
                    // Donations Tab
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GlassmorphismTheme.md),
                      child: GlassCard(
                        child: Padding(
                          padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                          child:
                              ProfileRecentDonations(profile: widget.profile),
                        ),
                      ),
                    ),
                    // Rewards Tab
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GlassmorphismTheme.md),
                      child: GlassCard(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                          child: Column(
                            children: [
                              // User Stats Section
                              GlassCard(
                                hasGoldBorder: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      GlassmorphismTheme.lg),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.profile.username!,
                                        style: TextStyle(
                                          color: GlassmorphismTheme.gold,
                                          fontSize: GlassmorphismTheme.h3Size,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: GlassmorphismTheme.md),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildStatItem(
                                            'Orders',
                                            widget.profile.orders!.length
                                                .toString(),
                                            isDark,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 1,
                                            color: GlassmorphismTheme.gold
                                                .withOpacity(0.3),
                                          ),
                                          _buildStatItem(
                                            'Pending',
                                            '1',
                                            isDark,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: GlassmorphismTheme.lg),

                              // Transactions Section
                              GlassCard(
                                hasGoldBorder: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      GlassmorphismTheme.lg),
                                  child: Column(
                                    children: [
                                      Text(
                                        'My Transactions',
                                        style: TextStyle(
                                          fontSize: GlassmorphismTheme.h3Size,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? GlassmorphismTheme.textPrimary
                                              : GlassmorphismTheme.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: GlassmorphismTheme.md),
                                      SizedBox(
                                        height: height * 0.4,
                                        child: UserProfileDetailTabs(
                                            profile: widget.profile),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, bool isDark) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: GlassmorphismTheme.textSecondary,
            fontSize: GlassmorphismTheme.captionSize,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: GlassmorphismTheme.gold,
            fontSize: GlassmorphismTheme.h3Size,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  SizedBox buildProfileRecentDonations(BuildContext context) {
    return SizedBox(
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
                style: TextStyle(color: Colors.amber, fontSize: 20),
              ),
            ),
          ),
          widget.profile.userdonations!.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.profile.userdonations!.length,
                      itemBuilder: (context, index) {
                        if (widget.profile.userdonations![index].nonprofit !=
                            null) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                        context: (context),
                                        builder: (_) {
                                          return Dialog(
                                            backgroundColor: Colors.grey,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60)),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .4,
                                                child: const Text('hey')),
                                          );
                                        });
                                  },
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                14),
                                        image: DecorationImage(
                                            image: NetworkImage(widget
                                                .profile
                                                .userdonations![index]
                                                .nonprofit!
                                                .logo!)),
                                        shape: BoxShape.rectangle,
                                      )),
                                ),
                              )
                            ],
                          );
                        } else if (widget
                                .profile.userdonations![index].atrocity !=
                            null) {
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.amberAccent,
                                      ),
                                      child: Center(
                                          child: Text(
                                        widget.profile.userdonations![index]
                                            .atrocity!.title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            backgroundColor: Colors.black38),
                                      ))))
                            ],
                          );
                        } else if (widget
                                .profile.userdonations![index].project !=
                            null) {
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(widget
                                              .profile
                                              .userdonations![index]
                                              .project!
                                              .title
                                              .toString()))))
                            ],
                          );
                        }
                        return Container(
                          child: Text(
                            widget.profile.userdonations![index].id.toString(),
                            style: const TextStyle(color: Colors.white),
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
    );
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Altrue Stats',
            style: TextStyle(
              color: GlassmorphismTheme.gold,
              fontSize: GlassmorphismTheme.h2Size,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.lg),

          // Stats Cards
          GlassCard(
            hasGoldBorder: true,
            margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
            child: Padding(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Donations',
                        style: TextStyle(
                          color: isDark
                              ? GlassmorphismTheme.textSecondary
                              : GlassmorphismTheme.textSecondary,
                          fontSize: GlassmorphismTheme.bodySize,
                        ),
                      ),
                      Text(
                        '\$${widget.profile.donationTotal ?? '0'}',
                        style: TextStyle(
                          color: GlassmorphismTheme.gold,
                          fontSize: GlassmorphismTheme.h3Size,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: GlassmorphismTheme.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Organizations',
                        style: TextStyle(
                          color: isDark
                              ? GlassmorphismTheme.textSecondary
                              : GlassmorphismTheme.textSecondary,
                          fontSize: GlassmorphismTheme.bodySize,
                        ),
                      ),
                      Text(
                        '${widget.profile.nonProfitList ?? '0'}',
                        style: TextStyle(
                          color: GlassmorphismTheme.gold,
                          fontSize: GlassmorphismTheme.h3Size,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Impact Score Card
          GlassCard(
            hasGoldBorder: true,
            margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
            child: Padding(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Impact Score',
                    style: TextStyle(
                      color: isDark
                          ? GlassmorphismTheme.textPrimary
                          : GlassmorphismTheme.textPrimary,
                      fontSize: GlassmorphismTheme.h3Size,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: GlassmorphismTheme.gold,
                        size: 20,
                      ),
                      const SizedBox(width: GlassmorphismTheme.sm),
                      Text(
                        '${widget.profile.altrueLevel!.levelNumber ?? '0'}',
                        style: TextStyle(
                          color: GlassmorphismTheme.gold,
                          fontSize: GlassmorphismTheme.h2Size,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Existing widgets with updated styling
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return MediterranesnDietView(
                isProfileInfo: true,
                textColor: isDark
                    ? GlassmorphismTheme.textPrimary
                    : GlassmorphismTheme.textPrimary,
                isCompanyInfo: false,
                profile: widget.profile,
                color: isDark
                    ? GlassmorphismTheme.darkSecondary
                    : GlassmorphismTheme.textSecondary,
              );
            },
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          WaterView(
            profile: widget.profile,
          ),
        ],
      ),
    );
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
