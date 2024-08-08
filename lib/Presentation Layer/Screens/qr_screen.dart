import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Image(
            image: AssetImage('images/Altrue Logo White.png'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image(
                      image: NetworkImage(profile.qrCode!, scale: .10),
                    ),
                    const SizedBox(height: 43),
                    Text(
                      'Scan${profile.username!}s profile to donate to support their favorite causes',
                      style: const TextStyle(fontSize: 22, color: Colors.amber),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))));
  }
}
