import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';

import '../Widgets/credit_card_storage.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return CreditCardPageState();
  }
}

class CreditCardPageState extends State<CreditCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String expMonth = '';
  String expYear = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      print([
        cardNumber.replaceAll(" ", ""),
        cvvCode,
        expiryDate.substring(0, 2),
        cardHolderName,
        expiryDate.substring(expiryDate.length - 2),
      ]);
      // Dispatch CreatePaymentMethod event to bloc (assuming bloc is provided in widget tree)
      context.read<ProfileBloc>().add(CreatePaymentMethod(
            cardNumber: cardNumber.replaceAll(' ', ''),
            cvv: cvvCode,
            expMonth: int.parse(expiryDate.substring(0, 2)),
            cardholderName: cardHolderName,
            expYear: int.parse(expiryDate.substring(expiryDate.length - 2)),
          ));
    } else {
      _formKey.currentState!.reset();
    }
  }

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    context.read<ProfileBloc>().add(FetchPaymentMethod());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Credit Card View Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                // image: !useBackgroundImage
                //     ? const DecorationImage(
                //         image: ExactAssetImage('images/bg.png'),
                //         fit: BoxFit.fill,
                //       )
                //     : null,
                color: Colors.black,
              ),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    CreditCardWidget(
                      glassmorphismConfig: useGlassMorphism
                          ? Glassmorphism.defaultConfig()
                          : null,
                      cardNumber: state.paymentMethodDetails != null? '42424 1213 1223 ${state.paymentMethodDetails!.last4}': cardNumber,
                      expiryDate: state.paymentMethodDetails != null? state.paymentMethodDetails!.getCombinedExpiration:expiryDate,
                      cardHolderName: state.paymentMethodDetails != null? state.paymentMethodDetails!.name: cardHolderName,
                      cvvCode: state.paymentMethodDetails != null ? '***':cvvCode,
                      showBackView: isCvvFocused,
                      obscureCardNumber: true,
                      obscureInitialCardNumber: true,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      cardBgColor: Colors.blue,
                      backgroundImage:
                          useBackgroundImage ? 'images/card_bg.png' : null,
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange:
                          (CreditCardBrand creditCardBrand) {},
                      customCardTypeIcons: <CustomCardTypeIcon>[
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'images/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            CreditCardForm(
                                formKey: _formKey,
                                obscureCvv: true,
                                obscureNumber: true,
                                cardNumber: cardNumber,
                                cvvCode: cvvCode,
                                isHolderNameVisible: true,
                                isCardNumberVisible: true,
                                isExpiryDateVisible: true,
                                cardHolderName: cardHolderName,
                                expiryDate: expiryDate,
                                themeColor: Colors.blue,
                                textColor: Colors.white,
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                ),
                                expiryDateDecoration: InputDecoration(
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),
                                cardHolderDecoration: InputDecoration(
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Card Holder',
                                ),
                                onCreditCardModelChange:
                                    onCreditCardModelChange),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Glassmorphism',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Switch(
                                  value: useGlassMorphism,
                                  inactiveTrackColor: Colors.grey,
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  onChanged: (bool value) => setState(() {
                                    useGlassMorphism = value;
                                  }),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Card Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Switch(
                                  value: useBackgroundImage,
                                  inactiveTrackColor: Colors.grey,
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  onChanged: (bool value) => setState(() {
                                    useBackgroundImage = value;
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                backgroundColor: const Color(0xff1b447b),
                              ),
                              child: BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  if (state.status == ProfileStatus.updating) {
                                    return CircularProgressIndicator();
                                  }
                                  return Container(
                                    margin: const EdgeInsets.all(12),
                                    child: const Text(
                                      'Validate',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'halter',
                                        fontSize: 14,
                                        package: 'flutter_credit_card',
                                      ),
                                    ),
                                  );
                                },
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('valid');
                                  _submitForm(context);
                                } else {
                                  print('invalid!');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void getDate(String date) {
    final RegExp expiryRegExp =
        RegExp(r'^(\d{2})/(\d{2})$'); // Regular expression for MM/YY format

    if (expiryRegExp.hasMatch(date)) {
      final match = expiryRegExp.firstMatch(date)!;
      String expMonth =
          int.parse(match.group(1)!).toString(); // Extract month (group 1)
      String expYear =
          int.parse(match.group(2)!).toString(); // Extract year (group 2)

      // Use the extracted expMonth and expYear for your bloc and backend
    } else {
      // Handle invalid expiry date format (optional)
      // You can show an error message to the user indicating invalid format
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
