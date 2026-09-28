import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';
import '../../widgets/glass/glass_input.dart';
import 'dart:ui';

class LoginPageUp extends StatefulWidget {
  const LoginPageUp({super.key});

  @override
  State<LoginPageUp> createState() => _LoginPageUpState();
}

class _LoginPageUpState extends State<LoginPageUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          create: (context) => LoginBloc(
            sessionBLoc: context.read<SessionBLoc>(),
            userRepository: context.read<UserRepository>(),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: GlassmorphismTheme.xl),
                    
                    // Altrue Logo
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
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
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.xl),
                    
                    // App Name
                    Text(
                      'ALTRUE',
                      style: GlassmorphismTheme.heroStyle.copyWith(
                        letterSpacing: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.sm),
                    
                    // Tagline
                    GlassCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: GlassmorphismTheme.md,
                        vertical: GlassmorphismTheme.sm,
                      ),
                      borderRadius: 20,
                      hasGoldBorder: true,
                      child: Text(
                        'Where Giving Meets Impact',
                        style: GlassmorphismTheme.captionStyle.copyWith(
                          color: GlassmorphismTheme.gold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.xl),
                    
                    // Login Form
                    GlassCard(
                      padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                      child: _userLoginForm(),
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.md),
                    
                    _showSignUpLink(context),
                    
                    const SizedBox(height: GlassmorphismTheme.xl),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userLoginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackbar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _emailField(),
            const SizedBox(height: GlassmorphismTheme.md),
            _passwordField(),
            const SizedBox(height: GlassmorphismTheme.sm),
            _forgotPasswordLink(),
            const SizedBox(height: GlassmorphismTheme.lg),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // Update controller text when state changes
        if (_emailController.text != state.email) {
          _emailController.text = state.email;
          _emailController.selection = TextSelection.fromPosition(
            TextPosition(offset: _emailController.text.length),
          );
        }
        
        return GlassInput(
          controller: _emailController,
          hintText: 'Email Address',
          labelText: 'Email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginEmailChange(value)),
          validator: (value) =>
              state.isValidemail ? null : 'Please enter a valid email',
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // Update controller text when state changes
        if (_passwordController.text != state.password) {
          _passwordController.text = state.password;
          _passwordController.selection = TextSelection.fromPosition(
            TextPosition(offset: _passwordController.text.length),
          );
        }
        
        return GlassInput(
          controller: _passwordController,
          hintText: 'Password',
          labelText: 'Password',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPassWordChange(value)),
          validator: (value) => state.password.length > 5
              ? null
              : "Password must be at least 6 characters",
        );
      },
    );
  }

  Widget _forgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        child: Text(
          'Forgot Password?',
          style: GlassmorphismTheme.captionStyle.copyWith(
            color: GlassmorphismTheme.gold,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const Center(
                child: CircularProgressIndicator(
                  color: GlassmorphismTheme.gold,
                ),
              )
            : GlassButton(
                text: 'Sign In',
                variant: GlassButtonVariant.primary,
                isFullWidth: true,
                height: 56,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted(
                        email: _emailController.text, 
                        password: _passwordController.text));
                  } else {
                    context
                        .read<LoginBloc>()
                        .add(const LoginFailure(error: 'Login Failure'));
                  }
                },
              );
      },
    );
  }

  Widget _showSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: GlassmorphismTheme.bodyStyle.copyWith(
            color: GlassmorphismTheme.textSecondary,
          ),
        ),
        TextButton(
          onPressed: () => context.go('/signup'),
          child: Text(
            'Sign Up',
            style: GlassmorphismTheme.bodyStyle.copyWith(
              color: GlassmorphismTheme.gold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[800],
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
