import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/user_model.dart';

class ProfilePresentationScreen extends StatefulWidget {
  final Profile profile;
  const ProfilePresentationScreen({super.key, required this.profile});

  @override
  State<ProfilePresentationScreen> createState() =>
      _ProfilePresentationScreenState();
}

class _ProfilePresentationScreenState extends State<ProfilePresentationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top container (white background)
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://i.ibb.co/yPCqbSG/altruecompany-placeholder.png'), // Placeholder image
                ),
                const SizedBox(height: 10),
                Text(
                  'User Blurb Here',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Row of 3 columns for information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _InfoColumn(title: 'Location', value: 'City, Country'),
                    _InfoColumn(title: 'Favorite Cause', value: 'Cause Name'),
                    _InfoColumn(title: 'Another Info', value: 'Some Value'),
                  ],
                ),
                const SizedBox(height: 20),
                // Circular pill with icon and text
                Positioned(
                  top: -30, // To ensure it's on top of the divide
                  left: MediaQuery.of(context).size.width * 0.5 - 60,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info, size: 30, color: Colors.black),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            Text('Smaller text below', style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom container (black background)
          Expanded(
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Swipeable cards
                  Expanded(
                    child: Swiper(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return _buildCard(index);
                      },
                      pagination: SwiperPagination(
                        builder: SwiperPagination.dots,
                       
                      ),
                      control: SwiperControl(),
                      scrollDirection: Axis.horizontal,
                      itemWidth: double.infinity,
                      layout: SwiperLayout.STACK,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(int index) {
    switch (index) {
      case 0:
        return _Card(title: 'Donations', icon: Icons.attach_money, imageUrl: 'https://via.placeholder.com/150');
      case 1:
        return _Card(title: 'Favorite Causes', icon: Icons.favorite, imageUrl: 'https://via.placeholder.com/150');
      case 2:
        return _Card(title: 'Rewarded Items', icon: Icons.star, imageUrl: 'https://via.placeholder.com/150');
      default:
        return Container();
    }
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        Text(value, style: TextStyle(color: Colors.grey[800])),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imageUrl;

  const _Card({
    required this.title,
    required this.icon,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 40, color: Colors.amber),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Image.network(imageUrl, fit: BoxFit.cover, height: 150, width: double.infinity),
          ),
        ],
      ),
    );
  }
}