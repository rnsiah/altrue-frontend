import 'package:flutter/material.dart';

import '../../Data Layer/Models/user_model.dart';

class ProfileEditScreen extends StatefulWidget {
  final Profile profile;

  const ProfileEditScreen({super.key, required this.profile});

  
  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _aboutMeController = TextEditingController();
  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the initial values from the provided Profile
    _aboutMeController.text = widget.profile.description!;
    _streetAddressController.text = widget.profile.address!;
    _cityController.text = widget.profile.city!;
    _zipCodeController.text = widget.profile.zip!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.amber, // Set the app bar color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Edit Your Profile', style: TextStyle(fontSize: 20, color: Colors.amber)),
              TextFormField(
                controller: _aboutMeController,
                decoration: const InputDecoration(labelText: 'About Me', hintText: 'Tell us about yourself'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _streetAddressController,
                decoration: const InputDecoration(labelText: 'Street Address', hintText: '123 Main St'),
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City', hintText: 'New York'),
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(labelText: 'ZIP Code', hintText: '12345'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to change profile picture
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: const Text('Change Profile Picture'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to update profile with new information
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}