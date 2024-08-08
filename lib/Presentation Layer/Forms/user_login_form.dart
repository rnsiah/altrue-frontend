import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/login_bloc/bloc/login_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class LoginPageUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPageUp({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/pplhelping.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocProvider(
        create: (context) => LoginBloc(
          sessionBLoc: context.read<SessionBLoc>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Image(
                image: AssetImage('images/Altrue Logo White.png'),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_userLoginForm(), _showSignUpLink(context)],
            )),
      ),
    );
  }

  Widget _userLoginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formaStatus;
        if (formStatus is SubmissionFaiiled) {
          _showSnackbar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(23),
            child: Column(
              children: [
                _emailField(),
                _passwordField(),
                _loginButton(),
              ],
            )),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            style: const TextStyle(
                fontSize: 25, color: Colors.amber, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'email',
                labelStyle: TextStyle(fontSize: 25, color: Colors.white)),
            onChanged: (value) =>
                context.read<LoginBloc>().add(LoginEmailChange(value)),
            validator: (value) =>
                state.isValidemail ? null : 'Your email is not valid',
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            style: const TextStyle(
                fontSize: 25, color: Colors.amber, fontWeight: FontWeight.bold),
            obscureText: true,
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'password',
                labelStyle: TextStyle(fontSize: 25, color: Colors.white)),
            onChanged: (value) =>
                context.read<LoginBloc>().add(LoginPassWordChange(value)),
            validator: (value) => state.password.length > 5
                ? null
                : "Your password is not long enough",
          ),
        );
      },
    );
  }

  Widget _showSignUpLink(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: const Text(
          "Dont't have an account? Sign Up Now",
          style: TextStyle(color: Colors.amber),
        ),
        onPressed: () => context.read<ValidationCubit>().showSignUp(),
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formaStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : SizedBox(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  child: const Text(
                    'Login Now',
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginSubmitted(
                          email: state.email, password: state.password));
                    } else {
                      context
                          .read<LoginBloc>()
                          .add(const LoginFailure(error: 'Login Failure'));
                    }
                  },
                ),
              );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
