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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
            color: Colors.black,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => NonprofitsignupBloc(),
        child: Column(
          children: [
            const Text(
              'Welcome To Altrue Global',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Register Your Non Profit',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: _nonprofitForm()),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  Widget _nonprofitForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              _name(),
              _yearStarted(),
              _addressStreet(),
              _description(),
              _missionStatement(),
              _visionStatement(),
              _website(),
              _instagram(),
              _facebook(),
              _registerNonProfit(),
              Container(
                height: 50,
              )
            ],
          ),
        ));
  }

  Widget _name() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'NonProfit Name',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context
                      .read<NonprofitsignupBloc>()
                      .add(NonProfitNameChangeOnForm(npName: value))
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return 'Please choose a correct name';
              }
              return null;
            });
      },
    );
  }

  Widget _website() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            keyboardType: TextInputType.url,
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Organization website',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context
                      .read<NonprofitsignupBloc>()
                      .add(NonProfitWebsiteChangeOnForm(npWebsite: value))
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return 'Please choose a correct website';
              }
              return null;
            });
      },
    );
  }

  Widget _yearStarted() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Year Started',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context.read<NonprofitsignupBloc>().add(
                        NonProfitYearStartedChangeOnForm(
                            npYearStarted: (int.parse(value))),
                      ),
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return 'Please choose a correct year';
              }
              return null;
            });
      },
    );
  }

  Widget _addressStreet() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            keyboardType: TextInputType.streetAddress,
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Street Address',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context
                      .read<NonprofitsignupBloc>()
                      .add(NonProfitAddressChangeOnForm(npAddress: value))
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return 'Please choose a correct address';
              }
              return null;
            });
      },
    );
  }

  Widget _description() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            maxLines: 6,
            keyboardType: TextInputType.streetAddress,
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Give A Description Of Your Organization',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context.read<NonprofitsignupBloc>().add(
                      NonProfitDescriptionChangeOnForm(npDescription: value))
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return 'Please describe your organization';
              }
              return null;
            });
      },
    );
  }

  Widget _missionStatement() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            maxLines: 6,
            keyboardType: TextInputType.streetAddress,
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: "Your organization's mission statement",
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context.read<NonprofitsignupBloc>().add(
                      NonProfitMissionStatementChangeOnForm(npMission: value))
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return "Please enter your organization's mission";
              }
              return null;
            });
      },
    );
  }

  Widget _visionStatement() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            maxLines: 6,
            keyboardType: TextInputType.streetAddress,
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Organization Vision Statement',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context.read<NonprofitsignupBloc>().add(
                      NonProfitVisionStatementChangeOnForm(npVision: value))
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return "Please enter your organization's vision statement";
              }
              return null;
            });
      },
    );
  }

  // Widget _country() {
  Widget _instagram() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            initialValue: '@',
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'instagram',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context
                      .read<NonprofitsignupBloc>()
                      .add(NonProfitInstagramChangeOnForm(npInstagram: value))
                },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return "Please enter your organization's instagram";
              }
              return null;
            });
      },
    );
  }

  Widget _facebook() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: "Organization's Facebook",
                labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
            onChanged: (value) {
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitFacebookChangeOnForm(npFacebook: value));
            },
            validator: (value) {
              if (value!.length < 3 || value.isEmpty) {
                return "Please enter your organization's facebook";
              }
              return null;
            });
      },
    );
  }

  Widget _logo() {
    final ImagePicker picker = ImagePicker();
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return Row(children: [
          MaterialButton(
            color: Colors.black,
            child: const Text(
              'Upload Logo',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () async {
              final XFile? logo =
                  await picker.pickImage(source: ImageSource.gallery);
              final Image img = Image.file(File(logo!.path));

              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitLogoChangeOnForm(npLogo: img));
            },
          ),
          TextField(
              style: const TextStyle(color: Colors.amber),
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)),
                  labelText: 'Paste logo image address',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
              onChanged: (value) => {}),
        ]);
      },
    );
  }

  Widget _mainImage() {
    XFile picture;
    final ImagePicker picker = ImagePicker();
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return Row(children: [
          MaterialButton(
            color: Colors.black,
            child: const Text(
              'Upload Logo',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () async {
              final XFile? mainImage =
                  await picker.pickImage(source: ImageSource.gallery);

              final Image img = Image.file(File(mainImage!.path));
              // ignore: use_build_context_synchronously
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitLogoChangeOnForm(npLogo: img));
            },
          ),
          TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Paste logo image address',
                labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
            onChanged: (value) {},
          )
        ]);
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _registerNonProfit() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        if (state.status is FormSubmitting) {
          return const CircularProgressIndicator();
        }
        return MaterialButton(
          color: Colors.amber,
          child: const Text(
            'Register NonProfit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            print([state.instagram]);
            if (_formKey.currentState!.validate()) {
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitSignUpFormCompletion(
                      nonprofit: NonProfitCompletion(
                        profile: widget.profile,
                        name: state.name,
                        description: state.description,
                        facebook: state.facebook,
                        missionStatement: state.missionStatement,
                        visionStatement: state.visionStatement,
                        yearStarted: state.yearStarted!,
                      ),
                      profile: widget.profile));
              context.read<ProfileBloc>().add(const FetchProfile());

              // NonProfitSignUpFormCompletion(
              //     facebook: state.facebook,
              //     instagram: state.instagram,
              //     mission: state.missionStatement,
              //     vision: state.visionStatement,
              //     website: state.website,
              //     yearStarteed: state.yearStarted!,
              //     profile: widget.profile,
              //     name: state.name,
              //     description: state.description));
            } else {
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitCreationError(errorMessage: "Exception"));
            }
          },
        );
      },
    );
  }
}
