import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
            Text('Terms and Condtions',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: const [Text('')],
        ),
      ),
    );
  }
}
