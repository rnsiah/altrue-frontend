import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class AddressForm extends StatefulWidget {
  Profile profile;
   AddressForm({super.key, required this.profile});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  bool useUploadedAddress = false;
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  void initState(){
    super.initState();
    addressController = TextEditingController(text: widget.profile.address);
    cityController = TextEditingController(text:widget.profile.city);
    zipController = TextEditingController(text: widget.profile.zip);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: addressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: cityController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: stateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'State',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Theme(
                  data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: zipController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your zip code';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Zip Code',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                value: useUploadedAddress,
                onChanged: (value) {
                  setState(() {
                    useUploadedAddress = value!;
                  });
                },
              ),
              Text('Use a new address'),
            ],
          ),
        ],
      ),
    );
  }
}
