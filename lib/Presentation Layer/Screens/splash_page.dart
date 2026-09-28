import 'package:flutter/material.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Theme/glass_widgets.dart';
import 'package:lovelovelove/Theme/glass_effects.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? password;
  String? username;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: darkGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(GlassmorphismTheme.lg),
              child: GlassCard(
                padding: const EdgeInsets.all(GlassmorphismTheme.xl),
                borderRadius: GlassmorphismTheme.radius2Xl,
                opacity: 0.15,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Logo
                    const Image(
                      image: AssetImage('images/Altrue Logo White.png'),
                      height: 80,
                    ),
                    const SizedBox(height: GlassmorphismTheme.lg),
                    
                    // Title
                    Text(
                      'Welcome Back',
                      style: GlassmorphismTheme.h1Style.copyWith(
                        color: GlassmorphismTheme.gold,
                      ),
                    ),
                    const SizedBox(height: GlassmorphismTheme.md),
                    
                    // Form
                    Form(
                      child: Column(
                        children: <Widget>[
                          GlassInput(
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          const SizedBox(height: GlassmorphismTheme.md),
                          
                          GlassInput(
                            hintText: 'Username',
                            prefixIcon: Icons.person_outlined,
                            onChanged: (value) {
                              username = value;
                            },
                          ),
                          const SizedBox(height: GlassmorphismTheme.md),
                          
                          GlassInput(
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          const SizedBox(height: GlassmorphismTheme.md),
                          
                          GlassInput(
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outlined,
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.md),
                    
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot your password?',
                          style: GlassmorphismTheme.captionStyle.copyWith(
                            color: GlassmorphismTheme.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.md),
                    
                    // Sign In Button
                    GlassButton(
                      text: 'SIGN IN',
                      isAccent: true,
                      isFullWidth: true,
                      onPressed: () {
                        print(email);
                        print(password);
                      },
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.md),
                    
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.2),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                          child: Text(
                            'OR',
                            style: GlassmorphismTheme.captionStyle.copyWith(
                              color: GlassmorphismTheme.textSecondary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.2),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.md),
                    
                    // Facebook Button
                    GlassButton(
                      text: 'Sign up with Facebook',
                      icon: Icons.facebook,
                      isAccent: false,
                      isFullWidth: true,
                      onPressed: () {},
                    ),
                    
                    const SizedBox(height: GlassmorphismTheme.lg),
                    
                    // Sign Up Link
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: GlassmorphismTheme.bodyStyle.copyWith(
                              color: GlassmorphismTheme.textSecondary,
                            ),
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: GlassmorphismTheme.bodyStyle.copyWith(
                              color: GlassmorphismTheme.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}