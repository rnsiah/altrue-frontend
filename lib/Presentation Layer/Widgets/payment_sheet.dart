import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/hybrid_payment_card.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet_profile_card_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../Data Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import '../../Data Layer/Blocs/order_status_bloc/bloc/order_status_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import '../../Data Layer/Models/order_item_model.dart';

import 'address_form.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  UserRepository repo = UserRepository();
  List<OrderItem> items = [];
  Map<String, dynamic> intentData = {};

  @override
  Widget build(BuildContext context) {
    double _amount = 0;
    return BlocProvider.value(
      value: context.read<ProfileBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Payment Page',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) => Text(
                      '\$${state.getCartPriceTotal()}', // Replace this with the actual total amount
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              const Text(
                'Payment Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AddressForm(),
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context,state){
                return ProfilePaymentCard(profile:state.profile!, heightFactor: .2,);
              }),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state.status == ProfileStatus.hybridPayment ||
                      state.status == ProfileStatus.hybridPaymentFunds ||
                      state.status == ProfileStatus.hybridPaymentPoints) {
                    return Container(
                        height: MediaQuery.of(context).size.height * .2,
                        child: EnterPointsWidget(
                          availablePoints: state.profile!.altruePoints!,
                          shirts: context.read<CartBloc>().state.cart,
                        ));
                  }
                  return Spacer();
                },
              ),
              // Text(items[0].shirt.name!),

              Column(
                children: [
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state.status == ProfileStatus.paymentAccepted) {
                        context.read<CartBloc>().add(PaymentAccepted());

                        context.go('/userActionScreen/thankyou',extra: ThankYouScreenArguments(isPurchase: true));
                      }
                      // TODO: implement listener
                    },
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state.status == ProfileStatus.confirmingOrder) {
                          return CircularProgressIndicator();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: double.infinity,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              color: Colors.black,
                              onPressed: () async {
                                if (context.read<ProfileBloc>().state.status !=
                                    ProfileStatus.updating) {
                                  context.read<ProfileBloc>().add(PayWithPoints(
                                      shirts:
                                          context.read<CartBloc>().state.cart));
                                }
                              },
                              child: const Text(
                                'Pay With Points',
                                style: TextStyle(
                                    color: Colors.amber, fontSize: 18),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .07,
                    width: double.infinity,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      color: Colors.black,
                      onPressed: () async {
                        ProfileBloc profileBloc = context.read<ProfileBloc>();
                        try {
                          await Stripe.instance.presentPaymentSheet();
                          await Future.delayed(Duration(seconds: 9));
                          profileBloc.add(ConfirmOrder());

                          try {} catch (e) {
                            print('Did not make a payment $e');
                          }
                        } catch (e) {
                          print('Error presenting payment sheet: $e');
                        }
                      },
                      child: const Text(
                        'Pay With Funds',
                        style: TextStyle(color: Colors.amber, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      height: MediaQuery.of(context).size.height * .07,
                      width: double.infinity,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)),
                        color: Colors.black,
                        onPressed: () async {
                          context.read<ProfileBloc>().add(
                              HybridPayment(shirts: items, pointAmount: null));
                        },
                        child: const Text(
                          'Pay With Points & Funds',
                          style: TextStyle(color: Colors.amber, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
