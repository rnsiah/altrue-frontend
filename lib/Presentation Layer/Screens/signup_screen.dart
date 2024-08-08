import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

import 'package:video_player/video_player.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  VideoPlayerController? _controller;
  bool _visible = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _controller = VideoPlayerController.asset(
        Uri.encodeFull("videos/Ending poverty and hunger.mp4"));
    _controller!.initialize().then((value) {
      Timer(const Duration(milliseconds: 900), () {
        setState(() {
          _controller!.play();
          _visible = true;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
    super.dispose();
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0,
      duration: const Duration(milliseconds: 1000),
      child: VideoPlayer(_controller!),
    );
  }

  _getBackgroundColor() {
    return Container(color: Colors.transparent.withAlpha(120));
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(children: [
        _getVideoBackground(),
        getSignUp(context),
      ]),
    ));
  }

  SizedBox getSignUp(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocProvider(
            create: (context) => SignUpBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                validationCubit: context.read<ValidationCubit>()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_signUpForm(), _showLoginLink(context)],
            )));
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.all(23),
          child: Column(
            children: [
              Column(
                children: [
                  _emailField(),
                  _passWordField(),
                  _passWordField2(),
                  _altrueCodeCheckBox(),
                  _altrueCodeField(),
                  const SizedBox(height: 65),
                  _signUpButtons()
                ],
              ),
            ],
          )),
    );
  }

  Widget _altrueCodeCheckBox() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return CheckboxListTile(
        title: const Text(
          'I have an Altrue Donor Code',
          style: TextStyle(color: Colors.amber),
        ),
        value: state.hasAltrueCode,
        onChanged: (bool? value) {
          context.read<SignUpBloc>().add(
              SignUpAltrueCodeCheckboxChanged(hasAltrueCode: value ?? false));
        },
        controlAffinity: ListTileControlAffinity.leading,
      );
    });
  }

  Widget _altrueCodeField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.hasAltrueCode
            ? TextFormField(
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  label: Text(
                    'Altrue Donor Code',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                onChanged: (value) => context
                    .read<SignUpBloc>()
                    .add(SignUpAltrueCodeChanged(altrueCode: value)),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'email',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          validator: (value) =>
              state.isValidemail ? null : 'This is not a valid email',
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpEmailChanged(email: value)),
        );
      },
    );
  }

  Widget _passWordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.amber, fontSize: 16),
          obscureText: true,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          validator: (value) =>
              state.isValidpassword ? null : "This is not a valid password",
          onChanged: (value) => context
              .read<SignUpBloc>()
              .add(SignUpPassword1Changed(password1: value)),
        );
      },
    );
  }

  Widget _passWordField2() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
          obscureText: true,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          validator: (value) =>
              state.isValidpassword ? null : 'This is not abalid password',
          onChanged: (value) => context
              .read<SignUpBloc>()
              .add(SignUpPassword2Changed(password2: value)),
        );
      },
    );
  }

  Widget _showLoginLink(BuildContext context) {
    return SafeArea(
      child: TextButton(
          child: const Text(
            "Already have an account? Log in Now",
            style: TextStyle(color: Colors.amber),
          ),
          onPressed: () {
            _controller!.pause();
            context.read<ValidationCubit>().showLogin();
          }),
    );
  }

  Widget _signUpButtons() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formaStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  MaterialButton(
                      color: Colors.transparent,
                      elevation: 0,
                      minWidth: 350,
                      height: 60,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.amber)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                              SignUpSubmittedWithoutConfirmaation(
                                  email: state.email,
                                  password1: state.password1,
                                  password2: state.password2,
                                  altrueCode: state.hasAltrueCode
                                      ? state.altrueCode
                                      : null));
                        }
                      },
                      child: const Text(
                        'Sign Up - 1 Factor ',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SFUIDisplay',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  const SizedBox(height: 10),
                  MaterialButton(
                      color: Colors.amber,
                      elevation: 0,
                      minWidth: 350,
                      height: 60,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                              SignUpSubmittedWithConfirmation(
                                  email: state.email,
                                  password1: state.password1,
                                  password2: state.password2,
                                  altrueCode: state.hasAltrueCode
                                      ? state.altrueCode
                                      : null));
                        }
                      },
                      child: Row(children: const [
                        Text(
                          'Sign Up - 2 Factor ',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ])),
                ],
              );
      },
    );
  }
}
