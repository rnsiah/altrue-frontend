import 'package:flutter/material.dart';
import 'dart:ui';
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
      padding: const EdgeInsets.all(8.0),
      child: GlassCard(
        child: Container(
          height: screenHeight * heightFactor,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with Logo and Altrue Points
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Altrue Logo
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('images/Altrue Logo White.png'),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.05,
                  ),
                  // Altrue Points
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color(0xFFD4AF37),
                        size: screenHeight * 0.02,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Altrue Points:',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: screenHeight * 0.015,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${profile.altruePoints!}',
                        style: TextStyle(
                          color: const Color(0xFFD4AF37),
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // User Profile Section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Profile Picture
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withOpacity(0.5),
                        width: 2,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(profile.profilePicture!.url),
                      ),
                    ),
                    height: screenHeight * 0.06,
                    width: screenHeight * 0.06,
                  ),
                  const SizedBox(width: 12),
                  // Username
                  Expanded(
                    child: Text(
                      profile.username!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Altrue Level
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Level',
                        style: TextStyle(
                          fontSize: screenHeight * 0.015,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        profile.altrueLevel!.name,
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          color: const Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Balance Section with Gold Accent
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFD4AF37).withOpacity(0.1),
                      const Color(0xFFD4AF37).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: const Color(0xFFD4AF37),
                          size: screenHeight * 0.02,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Balance:',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: screenHeight * 0.016,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${profile.balance!}',
                      style: TextStyle(
                        color: const Color(0xFFD4AF37),
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Glass Card Widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}