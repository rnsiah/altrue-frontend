import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_input.dart';
import '../../widgets/glass/glass_button.dart';
import 'credit_card_storage.dart';

class CreditCardForm extends StatefulWidget {
  final VoidCallback? onSave;
  final bool showSaveButton;
  
  const CreditCardForm({
    super.key,
    this.onSave,
    this.showSaveButton = true,
  });

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();
  
  bool _isLoading = false;
  bool _saveCard = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    }
    // Remove spaces and validate length
    final cleanNumber = value.replaceAll(' ', '');
    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return 'Please enter a valid card number';
    }
    // Basic Luhn algorithm validation could be added here
    return null;
  }

  String? _validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter expiry date';
    }
    // Format: MM/YY
    final regex = RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$');
    if (!regex.hasMatch(value)) {
      return 'Please enter valid expiry date (MM/YY)';
    }
    
    // Check if date is not expired
    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(parts[1]) + 2000; // Assume 20XX
    
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;
    
    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'Card has expired';
    }
    
    return null;
  }

  String? _validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter CVV';
    }
    if (value.length < 3 || value.length > 4) {
      return 'Please enter valid CVV';
    }
    return null;
  }

  String? _validateCardHolder(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter cardholder name';
    }
    if (value.length < 3) {
      return 'Please enter a valid name';
    }
    return null;
  }

  void _formatCardNumber(String value) {
    // Remove all non-digit characters
    String cleanNumber = value.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Add spaces every 4 digits
    String formattedNumber = '';
    for (int i = 0; i < cleanNumber.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedNumber += ' ';
      }
      formattedNumber += cleanNumber[i];
    }
    
    // Update the controller without triggering onChanged
    if (_cardNumberController.text != formattedNumber) {
      _cardNumberController.value = TextEditingValue(
        text: formattedNumber,
        selection: TextSelection.collapsed(offset: formattedNumber.length),
      );
    }
  }

  void _formatExpiryDate(String value) {
    // Remove all non-digit characters
    String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Add slash after 2 digits
    if (cleanValue.length >= 2) {
      cleanValue = cleanValue.substring(0, 2) + '/' + cleanValue.substring(2);
    }
    
    // Update the controller without triggering onChanged
    if (_expiryDateController.text != cleanValue) {
      _expiryDateController.value = TextEditingValue(
        text: cleanValue,
        selection: TextSelection.collapsed(offset: cleanValue.length),
      );
    }
  }

  Future<void> _onSavePressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Save to secure storage if checkbox is checked
        if (_saveCard) {
          await CreditCardStorage.saveCreditCard(
            cardNumber: _cardNumberController.text,
            expiryDate: _expiryDateController.text,
            cvvCode: _cvvController.text,
            cardHolderName: _cardHolderController.text,
          );
        }

        widget.onSave?.call();
        
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_saveCard ? 'Card saved successfully' : 'Card validated successfully'),
              backgroundColor: GlassmorphismTheme.gold,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusMd),
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving card: ${e.toString()}'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusMd),
              ),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
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
            // Card Number Input
            GlassInput(
              controller: _cardNumberController,
              labelText: 'Card Number',
              hintText: '1234 5678 9012 3456',
              prefixIcon: Icons.credit_card_outlined,
              keyboardType: TextInputType.number,
              validator: _validateCardNumber,
              onChanged: _formatCardNumber,
              maxLength: 19, // 16 digits + 3 spaces
            ),
            
            const SizedBox(height: GlassmorphismTheme.md),
            
            // Expiry Date and CVV Row
            Row(
              children: [
                Expanded(
                  child: GlassInput(
                    controller: _expiryDateController,
                    labelText: 'Expiry Date',
                    hintText: 'MM/YY',
                    prefixIcon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.number,
                    validator: _validateExpiryDate,
                    onChanged: _formatExpiryDate,
                    maxLength: 5, // MM/YY
                  ),
                ),
                const SizedBox(width: GlassmorphismTheme.md),
                Expanded(
                  child: GlassInput(
                    controller: _cvvController,
                    labelText: 'CVV',
                    hintText: '123',
                    prefixIcon: Icons.lock_outline,
                    keyboardType: TextInputType.number,
                    validator: _validateCVV,
                    obscureText: true,
                    maxLength: 4,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: GlassmorphismTheme.md),
            
            // Cardholder Name Input
            GlassInput(
              controller: _cardHolderController,
              labelText: 'Cardholder Name',
              hintText: 'John Doe',
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.name,
              validator: _validateCardHolder,
              textInputAction: TextInputAction.done,
            ),
            
            const SizedBox(height: GlassmorphismTheme.md),
            
            // Save Card Checkbox
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
                        value: _saveCard,
                        onChanged: (value) {
                          setState(() {
                            _saveCard = value!;
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
                          'Save card for future use',
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
            
            if (widget.showSaveButton) ...[
              const SizedBox(height: GlassmorphismTheme.lg),
              
              // Save Button
              GlassButton(
                text: 'Save Card',
                icon: Icons.save_outlined,
                variant: GlassButtonVariant.primary,
                isFullWidth: true,
                onPressed: _onSavePressed,
                isLoading: _isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}