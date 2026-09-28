import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_input.dart';

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
    return GlassCard(
      padding: const EdgeInsets.all(GlassmorphismTheme.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Input
            GlassInput(
              controller: addressController,
              labelText: 'Address',
              hintText: 'Enter your street address',
              prefixIcon: Icons.home_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            
            const SizedBox(height: GlassmorphismTheme.md),
            
            // City Input
            GlassInput(
              controller: cityController,
              labelText: 'City',
              hintText: 'Enter your city',
              prefixIcon: Icons.location_city_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
            ),
            
            const SizedBox(height: GlassmorphismTheme.md),
            
            // State and Zip Code Row
            Row(
              children: [
                Expanded(
                  child: GlassInput(
                    controller: stateController,
                    labelText: 'State',
                    hintText: 'State',
                    prefixIcon: Icons.map_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: GlassmorphismTheme.md),
                Expanded(
                  child: GlassInput(
                    controller: zipController,
                    labelText: 'Zip Code',
                    hintText: 'ZIP',
                    prefixIcon: Icons.markunread_mailbox_outlined,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your zip code';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: GlassmorphismTheme.md),
            
            // Use New Address Checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusSm),
                    color: GlassmorphismTheme.glassWhite.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: useUploadedAddress,
                        onChanged: (value) {
                          setState(() {
                            useUploadedAddress = value!;
                          });
                        },
                        activeColor: GlassmorphismTheme.gold,
                        checkColor: GlassmorphismTheme.darkPrimary,
                        side: BorderSide(
                          color: GlassmorphismTheme.textSecondary,
                          width: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: GlassmorphismTheme.sm),
                        child: Text(
                          'Use a new address',
                          style: GlassmorphismTheme.bodyStyle.copyWith(
                            color: GlassmorphismTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
