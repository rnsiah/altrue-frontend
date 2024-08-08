import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/profile_page/rounded_image.dart';

class MyInfo extends StatelessWidget {
  final Profile profile;

  const MyInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedImage(
              imagePath: profile.profilePicture!.url,
              size: const Size.fromWidth(120.0),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(profile.username!),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  profile.username!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const Text(
                  ", 24",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        //altrue level do something if null
        Positioned(
            bottom: 80,
            child: profile.altrueLevel != null
                ? Text('Altrue Level:${profile.altrueLevel!.name}')
                : const Text('Altrue Level: 0'))
      ]),
    );
  }
}
