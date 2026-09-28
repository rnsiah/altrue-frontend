import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_bloc.dart';
//import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:go_router/go_router.dart';
import '../../Theme/glassmorphism_theme.dart';
import '../../Theme/glass_widgets.dart';
import 'dart:ui';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
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
        child: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is SubmissionFailed) {
                _showSnackbar(context, formStatus.exception.toString());
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: GlassmorphismTheme.xl),

                        // Logo
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
                                  color:
                                      GlassmorphismTheme.gold.withOpacity(0.3),
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

                        // Title
                        Text(
                          'Welcome Back',
                          style: GlassmorphismTheme.heroStyle,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: GlassmorphismTheme.sm),

                        Text(
                          'Sign in to continue',
                          style: GlassmorphismTheme.bodyStyle.copyWith(
                            color: GlassmorphismTheme.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: GlassmorphismTheme.xl),

                        // Glass Card Form
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              GlassmorphismTheme.radiusXl),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: GlassmorphismTheme.blurMedium,
                              sigmaY: GlassmorphismTheme.blurMedium,
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.all(GlassmorphismTheme.lg),
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
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    // Email Field
                                    GlassInput(
                                      controller: _emailController,
                                      hintText: 'Email Address',
                                      labelText: 'Email',
                                      prefixIcon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {},
                                    ),

                                    const SizedBox(
                                        height: GlassmorphismTheme.md),

                                    // Password Field
                                    GlassInput(
                                      controller: _passwordController,
                                      hintText: 'Password',
                                      labelText: 'Password',
                                      prefixIcon: Icons.lock_outline,
                                      obscureText: true,
                                    ),

                                    const SizedBox(
                                        height: GlassmorphismTheme.md),

                                    // Forgot Password
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          context.go('/forgot-password');
                                        },
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: GlassmorphismTheme.gold,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        height: GlassmorphismTheme.md),

                                    // Login Button
                                    state.formStatus is FormSubmitting
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xFFD4AF37),
                                            ),
                                          )
                                        : GlassButton(
                                            text: 'Sign In',
                                            isAccent: true,
                                            isFullWidth: true,
                                            onPressed: _onLoginButtonPressed,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: GlassmorphismTheme.xl),

                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GlassmorphismTheme.bodyStyle.copyWith(
                                color: GlassmorphismTheme.textSecondary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go('/signup');
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: GlassmorphismTheme.gold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
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
