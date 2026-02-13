import 'package:flutter/material.dart';

import '../../Data Layer/Models/user_model.dart';

class ProfilePaymentCard extends StatelessWidget {
  const ProfilePaymentCard({required this.profile, Key? key, required this.heightFactor}) : super(key: key);

  final Profile profile;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: MediaQuery.of(context).size.height *
            heightFactor, // Target 1/4 screen height
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
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
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.05,
                    
                  ),
                  Row(
                    children: [
                      const Text(
                        'Altrue Point:',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        '\$${profile.altruePoints!}',
                        style:  TextStyle(
                            color: Colors.amber,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ), // Adjust
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(profile.profilePicture!.url))),
                     height: screenHeight * 0.06, // Adjust
                    width: screenWidth * 0.1,
                  ),
                  Text(
                    profile.username!,
                    style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.03),
                  ),
                  Spacer(), // Adjust height as needed
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "Altrue Level", // Placeholder text
                        style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        profile.altrueLevel!.name, // Placeholder text
                        style:  TextStyle(
                            fontSize: screenHeight * 0.025, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Altrue Balance:',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    '\$${profile.balance!}',
                    style:  TextStyle(
                        color: Colors.amber,
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
