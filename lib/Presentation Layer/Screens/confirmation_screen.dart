import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ConfirmationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/pplhelping.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
          ),
          body: _confirmationForm()
          ),
    );
  }

  Widget _confirmationForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _userNameField(),
          const SizedBox(
            height: 12,
          ),
          _codeField(),
          const SizedBox(height: 7,),
          _confirmationButton(),
        ],
      ),
    );
  }

  Widget _userNameField() {
    return TextFormField(
      decoration: const InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: 'email',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
    );
  }

  Widget _codeField() {
    return TextFormField(
      decoration: const InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: 'Confirmation Code',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
    );
  }

  Widget _confirmationButton() {
    return ElevatedButton(
      child: const Text('Confirm Now',

      ),
      onPressed: () {},
    );
  }
}
