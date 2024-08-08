import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Presentation%20Layer/Forms/user_login_form.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/confirmation_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Intro_Slider/intro_slider.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationCubit, ValidationState>(
      builder: (context, state) {
        return Navigator(
            pages: [
              if (state == ValidationState.intro)
                const MaterialPage(child: IntroductionSlider()),
              if (state == ValidationState.login)
                MaterialPage(child: LoginPageUp()),
              if (state == ValidationState.signUpWithOutConfirmation)
                const MaterialPage(child: SignUpScreen()),
              if (state == ValidationState.signup ||
                  state == ValidationState.confirmSignUp) ...[
                const MaterialPage(child: SignUpScreen()),
                if (state == ValidationState.confirmSignUp)
                  MaterialPage(child: ConfirmationScreen()),
              ]
            ],
            onPopPage: (route, result) => route.didPop(result),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (BuildContext context) => makeRoute(
                    context: context,
                    routeName: settings.name!,
                    arguments: settings.arguments),
              );
            });
      },
    );
  }
}

class FunctionalityRouter extends StatelessWidget {
  const FunctionalityRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Navigator(
      pages: [],
    );
  }
}
