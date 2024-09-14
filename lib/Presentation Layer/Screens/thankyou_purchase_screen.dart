import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';

import '../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';

class ThankYouPurchaseScreen extends StatefulWidget {
  final bool? isNonProfit;
  final bool? isPurchase;
  final bool? isAtrocity;
  final bool? isProject;

  const ThankYouPurchaseScreen({
    super.key,
     this.isAtrocity,
     this.isNonProfit,
     this.isPurchase,
     this.isProject
  });

  @override
  State<ThankYouPurchaseScreen> createState() => _ThankYouPurchaseScreenState();
}

class _ThankYouPurchaseScreenState extends State<ThankYouPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Thank You'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final userProfile = state.profile!;
          final donation = userProfile.userdonations!.last;
          // final imageUrl = donation.nonprofit?? donation.nonprofit!.logo ??
          //     ''
          // //         ''; // Assuming imageUrl is part of the donation object
          // final title = donation.nonprofit!.name ??
              'Donation'; // Assuming title is part of the donation object
          final userName = userProfile.username ?? 'User';
          final currentBalance = userProfile.balance ?? 0.0;
          final altruePoints = userProfile.altruePoints ?? 0;
          final userLevel = userProfile.altrueLevel!.levelNumber ?? 1;
          final nextLevelPoints = userProfile.altrueLevel!.minimumPoints ?? 0;

          return SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: -150,
                  right: -150,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://minnesotareformer.com/wp-content/uploads/2023/10/GettyImages-1740223908.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 160), // Space for the semi-circle
                      Text(
                        'Thank You!',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.isAtrocity!=null
                            ? 'Your support helps address atrocities.'
                            : widget.isNonProfit!=null
                                ? 'Thank you for supporting a nonprofit.'
                                : 'Thank you for your purchase.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.amber, width: 2),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    userName[0].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User: $userName',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Level: $userLevel',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Current Balance: \$${currentBalance.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Altrue Points: $altruePoints',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(height: 10),
                            nextLevelPoints > 0
                                ? Text(
                                    'Points to next level: ${nextLevelPoints - altruePoints}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Congratulations on reaching the top level!',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.amber,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                           Navigator.of(context).popAndPushNamed('/home', 
                           arguments: HomeArguments(profile: context.read<ProfileBloc>().state.profile!, 
                           user: context.read<ProfileBloc>().state.user!, 
                           cartBloc: context.read<CartBloc>()));
                        },
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
