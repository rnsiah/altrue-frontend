// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobile/Data_Layer/Blocs/login_bloc/bloc/login_bloc.dart';

// class LoginForm extends StatefulWidget {
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     _onLoginButtonPressed() {
//       BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
//           email: _emailController.text, password: _passwordController.text));
//     }

//     return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
//       if (state is LoginFailure) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('${state.error}', style: TextStyle(color: Colors.white),
//             ),
//             backgroundColor: Colors.black,));
//       }
//     },
//     child: BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
//       return Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image:AssetImage('images/pplhelping.jpg'),
//             fit: BoxFit.cover,),
//         ),
//         child: Form(child: Padding(padding: EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
              
//               decoration: InputDecoration(
                
                
//                 labelText: 'Email Address',  icon: Icon(Icons.email)
//               ),controller: _emailController,
//             ),
//             TextFormField(decoration: InputDecoration(
//               labelText: 'Password', icon: Icon(Icons.password),
//             ),
//             controller: _passwordController,
//             obscureText: true,),
//             Container(
//               width:MediaQuery.of(context).size.width * 0.85,
//               height: MediaQuery.of(context).size.height * 0.22,
//               child: Padding(
//                 padding: EdgeInsets.only(top: 30.0),
//                   child: MaterialButton(height: 22,

//                     color: Colors.amber,
//                     onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
//                   child: Text('Login', style: TextStyle(
//                     fontSize: 24,
//                   ),
//                       ),
//                       shape: StadiumBorder(side: BorderSide(
//                         color: Colors.black,
//                         width: 2,
//                       )),
//                     ),
//                   ),
//             ),
            
//           ],
//         ),)),
//       );
//     },));
//   }
// }
