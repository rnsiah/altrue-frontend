import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/sign_up_bloc/sign_up_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import '../../Theme/glassmorphism_theme.dart';
import '../../Theme/glass_widgets.dart';
import 'dart:ui';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GlassmorphismTheme.darkPrimary,
              GlassmorphismTheme.darkSecondary,
              Color(0xFF0d0d0d),
            ],
          ),
        ),
        child: BlocProvider(
          create: (context) => SignUpBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              validationCubit: context.read<ValidationCubit>()),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: GlassmorphismTheme.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: GlassmorphismTheme.gold),
                        onPressed: () => context.go('/login'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Altrue Logo
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: GlassmorphismTheme.darkSecondary,
                        border: Border.all(
                          color: GlassmorphismTheme.gold,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: GlassmorphismTheme.gold.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite,
                          color: GlassmorphismTheme.gold,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      'Create Account',
                      style:
                          GlassmorphismTheme.heroStyle.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      'Join our community of changemakers',
                      style: GlassmorphismTheme.bodyStyle.copyWith(
                        color: GlassmorphismTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Glass Card Form
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(GlassmorphismTheme.radiusXl),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: GlassmorphismTheme.blurMedium,
                          sigmaY: GlassmorphismTheme.blurMedium,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                                GlassmorphismTheme.radiusXl),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: _signUpForm(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    _showLoginLink(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _emailField(),
          const SizedBox(height: GlassmorphismTheme.md),
          _passWordField(),
          const SizedBox(height: GlassmorphismTheme.md),
          _confirmPasswordField(),
          const SizedBox(height: GlassmorphismTheme.md),
          _altrueCodeCheckBox(),
          _altrueCodeField(),
          const SizedBox(height: GlassmorphismTheme.lg),
          _termsCheckbox(),
          const SizedBox(height: GlassmorphismTheme.lg),
          _signUpButtons(),
        ],
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _glassInput(
          hintText: 'Email Address',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              state.isValidemail ? null : 'Please enter a valid email',
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpEmailChanged(email: value)),
        );
      },
    );
  }

  Widget _passWordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _glassInput(
          hintText: 'Password',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          validator: (value) => state.isValidpassword
              ? null
              : "Password must be at least 6 characters",
          onChanged: (value) => context
              .read<SignUpBloc>()
              .add(SignUpPassword1Changed(password1: value)),
        );
      },
    );
  }

  Widget _confirmPasswordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _glassInput(
          hintText: 'Confirm Password',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          validator: (value) {
            if (value != state.password1) {
              return 'Passwords do not match';
            }
            return state.isValidpassword ? null : 'Invalid password';
          },
          onChanged: (value) => context
              .read<SignUpBloc>()
              .add(SignUpPassword2Changed(password2: value)),
        );
      },
    );
  }

  Widget _glassInput({
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: GlassmorphismTheme.blurLight,
          sigmaY: GlassmorphismTheme.blurLight,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: GlassmorphismTheme.glassWhite,
            borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: TextFormField(
            style: GlassmorphismTheme.bodyStyle,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  const TextStyle(color: GlassmorphismTheme.textTertiary),
              prefixIcon: Icon(
                prefixIcon,
                color: GlassmorphismTheme.textSecondary,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(GlassmorphismTheme.md),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusLg),
                borderSide:
                    const BorderSide(color: GlassmorphismTheme.gold, width: 2),
              ),
            ),
            validator: validator,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _altrueCodeCheckBox() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return CheckboxListTile(
        title: const Text(
          'I have an Altrue Donor Code',
          style: TextStyle(color: GlassmorphismTheme.gold, fontSize: 14),
        ),
        value: state.hasAltrueCode,
        onChanged: (bool? value) {
          context.read<SignUpBloc>().add(
              SignUpAltrueCodeCheckboxChanged(hasAltrueCode: value ?? false));
        },
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: GlassmorphismTheme.gold,
        checkColor: Colors.black,
      );
    });
  }

  Widget _altrueCodeField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.hasAltrueCode
            ? Padding(
                padding: const EdgeInsets.only(top: GlassmorphismTheme.sm),
                child: _glassInput(
                  hintText: 'Altrue Donor Code',
                  prefixIcon: Icons.card_giftcard,
                  onChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(SignUpAltrueCodeChanged(altrueCode: value)),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _termsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreedToTerms,
          onChanged: (value) {
            setState(() {
              _agreedToTerms = value ?? false;
            });
          },
          activeColor: GlassmorphismTheme.gold,
          checkColor: Colors.black,
        ),
        Expanded(
          child: Text(
            'I agree to the Terms of Service and Privacy Policy',
            style: GlassmorphismTheme.bodyStyle.copyWith(
              color: GlassmorphismTheme.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _signUpButtons() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const Center(
                child: CircularProgressIndicator(
                  color: GlassmorphismTheme.gold,
                ),
              )
            : GlassButton(
                text: 'Create Account',
                isAccent: true,
                isFullWidth: true,
                onPressed: _agreedToTerms
                    ? () {
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
                      }
                    : null,
              );
      },
    );
  }

  Widget _showLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: GlassmorphismTheme.bodyStyle.copyWith(
            color: GlassmorphismTheme.textSecondary,
          ),
        ),
        TextButton(
          onPressed: () => context.go('/login'),
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: GlassmorphismTheme.gold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
