import 'package:flutter/material.dart';

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
          image: DecorationImage(
        image: AssetImage('images/pplhelping.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                const Image(
                  image: AssetImage('images/Altrue Logo White.png'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'email',
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'email',
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'email',
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    'Forgot your password?',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'SFUIDisplay',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      print(email);
                      print(password);
                    },
                    color: Colors.amber,
                    elevation: 0,
                    minWidth: 350,
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    elevation: 0,
                    minWidth: 350,
                    height: 60,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const <Widget>[
                        Icon(Icons.add),
                        Text(
                          'Sign up with facebook',
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'SFUIDisplay'),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.white,
                              fontSize: 15,
                            )),
                        TextSpan(
                            text: "sign up",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.amber,
                              fontSize: 15,
                            ))
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
