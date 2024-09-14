import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class UserLevelHeroCard extends StatelessWidget {
  const UserLevelHeroCard({required this.profile, Key? key, required this.heightFactor}) : super(key: key);

  final Profile profile;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    double pointsProgress = profile.altruePoints! / profile.altruePoints!; // Assuming `pointsForNextLevel` is in Profile

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: MediaQuery.of(context).size.height * heightFactor, // Target 1/4 screen height
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(.5, 1.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('images/Altrue Logo White.png'))),
                    height: 40.0,
                    width: 50.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Altrue Points:',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        '\$${profile.altruePoints!}',
                        style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(profile.profilePicture!.url))),
                    height: 50.0,
                    width: 50,
                  ),
                  Text(
                    profile.username!,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Spacer(), 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Altrue Level",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        profile.altrueLevel!.name,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Points Progress:",
                    style: TextStyle(color: Colors.white),
                  ),
                  LinearProgressIndicator(
                    value: pointsProgress,
                    backgroundColor: Colors.white24,
                    color: Colors.amber,
                    minHeight: 8.0,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${profile.altruePoints!} / ${profile.altruePoints!} points to next level',
                    style: const TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}