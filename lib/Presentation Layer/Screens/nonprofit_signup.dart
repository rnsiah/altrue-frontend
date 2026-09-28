import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/NonProfit_Signup_bloc/bloc/nonprofitsignup_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_input.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

class NonProfitSignUp extends StatefulWidget {
  final Profile profile;
  const NonProfitSignUp({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<NonProfitSignUp> createState() => _NonProfitSignUpState();
}

class _NonProfitSignUpState extends State<NonProfitSignUp> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 7),
            onPressed: () => print('Search'),
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: GlassmorphismTheme.gold,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ]
                : [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ],
          ),
        ),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => NonprofitsignupBloc(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section
                  GlassCard(
                    margin:
                        const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                    hasGoldBorder: true,
                    child: Column(
                      children: [
                        Text(
                          'Welcome To Altrue Global',
                          style: GlassmorphismTheme.h2Style.copyWith(
                            color: GlassmorphismTheme.gold,
                          ),
                        ),
                        const SizedBox(height: GlassmorphismTheme.sm),
                        Text(
                          'Register Your Non Profit',
                          style: GlassmorphismTheme.h3Style.copyWith(
                            color: GlassmorphismTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Registration Form
                  GlassCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildNameField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildYearStartedField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildAddressField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildDescriptionField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildMissionStatementField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildVisionStatementField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildWebsiteField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildInstagramField(),
                          const SizedBox(height: GlassmorphismTheme.md),
                          _buildFacebookField(),
                          const SizedBox(height: GlassmorphismTheme.lg),
                          _buildLogoUploadSection(),
                          const SizedBox(height: GlassmorphismTheme.lg),
                          _buildMainImageUploadSection(),
                          const SizedBox(height: GlassmorphismTheme.xl),
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: 'NonProfit Name',
          prefixIcon: Icons.business,
          onChanged: (value) => context
              .read<NonprofitsignupBloc>()
              .add(NonProfitNameChangeOnForm(npName: value)),
          validator: (value) {
            if (value == null || value.length < 3 || value.isEmpty) {
              return 'Please choose a correct name';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildYearStartedField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: 'Year Started',
          prefixIcon: Icons.calendar_today,
          keyboardType: TextInputType.number,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.digitsOnly,
          // ],
          onChanged: (value) {
            if (value.isNotEmpty) {
              context.read<NonprofitsignupBloc>().add(
                    NonProfitYearStartedChangeOnForm(
                      npYearStarted: int.parse(value),
                    ),
                  );
            }
          },
          validator: (value) {
            if (value == null || value.length < 4 || value.isEmpty) {
              return 'Please enter a valid year';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildAddressField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: 'Street Address',
          prefixIcon: Icons.location_on,
          keyboardType: TextInputType.streetAddress,
          onChanged: (value) => context
              .read<NonprofitsignupBloc>()
              .add(NonProfitAddressChangeOnForm(npAddress: value)),
          validator: (value) {
            if (value == null || value.length < 3 || value.isEmpty) {
              return 'Please enter a valid address';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: 'Give A Description Of Your Organization',
          prefixIcon: Icons.description,
          maxLines: 4,
          keyboardType: TextInputType.multiline,
          onChanged: (value) => context
              .read<NonprofitsignupBloc>()
              .add(NonProfitDescriptionChangeOnForm(npDescription: value)),
          validator: (value) {
            if (value == null || value.length < 10 || value.isEmpty) {
              return 'Please describe your organization (minimum 10 characters)';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildMissionStatementField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: "Your organization's mission statement",
          prefixIcon: Icons.flag,
          maxLines: 4,
          keyboardType: TextInputType.multiline,
          onChanged: (value) => context
              .read<NonprofitsignupBloc>()
              .add(NonProfitMissionStatementChangeOnForm(npMission: value)),
          validator: (value) {
            if (value == null || value.length < 10 || value.isEmpty) {
              return "Please enter your organization's mission (minimum 10 characters)";
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildVisionStatementField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: 'Organization Vision Statement',
          prefixIcon: Icons.visibility,
          maxLines: 4,
          keyboardType: TextInputType.multiline,
          onChanged: (value) => context
              .read<NonprofitsignupBloc>()
              .add(NonProfitVisionStatementChangeOnForm(npVision: value)),
          validator: (value) {
            if (value == null || value.length < 10 || value.isEmpty) {
              return "Please enter your organization's vision (minimum 10 characters)";
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildWebsiteField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: 'Organization website',
          prefixIcon: Icons.language,
          keyboardType: TextInputType.url,
          onChanged: (value) => context
              .read<NonprofitsignupBloc>()
              .add(NonProfitWebsiteChangeOnForm(npWebsite: value)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return null; // Website is optional
            }
            if (value.length < 3 || !value.contains('.')) {
              return 'Please enter a valid website URL';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildInstagramField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: 'Instagram handle',
          prefixIcon: Icons.camera_alt,
          // initialValue: '@',
          onChanged: (value) => context
              .read<NonprofitsignupBloc>()
              .add(NonProfitInstagramChangeOnForm(npInstagram: value)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return null; // Instagram is optional
            }
            if (value.length < 2) {
              return 'Please enter a valid Instagram handle';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildFacebookField() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return GlassInput(
          hintText: "Organization's Facebook",
          prefixIcon: Icons.facebook,
          onChanged: (value) {
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitFacebookChangeOnForm(npFacebook: value));
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return null; // Facebook is optional
            }
            if (value.length < 3) {
              return "Please enter a valid Facebook page";
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildLogoUploadSection() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Organization Logo',
              style: GlassmorphismTheme.captionStyle.copyWith(
                color: GlassmorphismTheme.textSecondary,
              ),
            ),
            const SizedBox(height: GlassmorphismTheme.xs),
            Row(
              children: [
                GlassButton(
                  onPressed: () async {
                    final XFile? logo = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (logo != null) {
                      final Image img = Image.file(File(logo.path));
                      context
                          .read<NonprofitsignupBloc>()
                          .add(NonProfitLogoChangeOnForm(npLogo: img));
                    }
                  },
                  icon: Icons.upload,
                  text: 'Upload Logo',
                  // isAccent: false,
                ),
                const SizedBox(width: GlassmorphismTheme.md),
                Expanded(
                  child: GlassInput(
                    hintText: 'Or paste logo URL',
                    prefixIcon: Icons.link,
                    onChanged: (value) {
                      // Handle URL input if needed
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainImageUploadSection() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Main Organization Image',
              style: GlassmorphismTheme.captionStyle.copyWith(
                color: GlassmorphismTheme.textSecondary,
              ),
            ),
            const SizedBox(height: GlassmorphismTheme.xs),
            Row(
              children: [
                GlassButton(
                  onPressed: () async {
                    final XFile? mainImage = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (mainImage != null) {
                      final Image img = Image.file(File(mainImage.path));
                      context
                          .read<NonprofitsignupBloc>()
                          .add(NonProfitLogoChangeOnForm(npLogo: img));
                    }
                  },
                  icon: Icons.upload,
                  text: 'Upload Image',
                  // isAccent: false,
                ),
                const SizedBox(width: GlassmorphismTheme.md),
                Expanded(
                  child: GlassInput(
                    hintText: 'Or paste image URL',
                    prefixIcon: Icons.link,
                    onChanged: (value) {
                      // Handle URL input if needed
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        if (state.formStatus is FormSubmitting) {
          return const Center(
            child: CircularProgressIndicator(
              color: GlassmorphismTheme.gold,
            ),
          );
        }
        return GlassButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<NonprofitsignupBloc>().add(
                    NonProfitSignUpFormCompletion(
                      nonprofit: NonProfitCompletion(
                        profile: widget.profile,
                        name: state.name,
                        description: state.description,
                        facebook: state.facebook,
                        missionStatement: state.missionStatement,
                        visionStatement: state.visionStatement,
                        yearStarted: state.yearStarted!,
                      ),
                      profile: widget.profile,
                    ),
                  );
              context.read<ProfileBloc>().add(const FetchProfile());
            } else {
              context.read<NonprofitsignupBloc>().add(
                    NonProfitCreationError(
                        errorMessage: "Please fill all required fields"),
                  );
            }
          },
          text: 'Register NonProfit',
          isFullWidth: true,
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: GlassmorphismTheme.gold,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
