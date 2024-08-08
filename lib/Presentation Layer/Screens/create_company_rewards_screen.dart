import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';

import '../../Data Layer/Models/user_model.dart';

class CreateRewardsScreen extends StatefulWidget {
  final Profile profile;
  final ForProfitCompany company;
  const CreateRewardsScreen({super.key, required this.company, required this.profile});

  @override
  State<CreateRewardsScreen> createState() => _CreateRewardsScreenState();
}

class _CreateRewardsScreenState extends State<CreateRewardsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add Reward'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextField(
              controller: _discountController,
              decoration: const InputDecoration(
                labelText: 'Discount',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            MaterialButton(
              onPressed: () {
                // Handle form submission, send data to backend
                String title = _titleController.text;
                String description = _descriptionController.text;
                double discount = double.parse(_discountController.text);
                
                // You can create a request object or call your Bloc here
                // to send the reward details to your backend (Django)
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}