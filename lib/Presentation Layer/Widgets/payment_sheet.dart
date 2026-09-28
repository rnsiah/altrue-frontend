import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/hybrid_payment_card.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet_profile_card_widget.dart'
    hide GlassCard;
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../Data Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import '../../Data Layer/Blocs/order_status_bloc/bloc/order_status_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import '../../Data Layer/Models/order_item_model.dart';

import 'address_form.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';
import '../../widgets/glass/glass_input.dart';

class PaymentScreen extends StatefulWidget {
  Profile profile;
  PaymentScreen({super.key, required this.profile});

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
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Payment',
            style: GlassmorphismTheme.h1Style
                .copyWith(color: GlassmorphismTheme.gold),
          ),
          iconTheme: const IconThemeData(color: GlassmorphismTheme.gold),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                GlassmorphismTheme.darkPrimary,
                GlassmorphismTheme.darkSecondary,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Amount Card
                  GlassCard(
                    margin:
                        const EdgeInsets.only(bottom: GlassmorphismTheme.md),
                    hasGoldBorder: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: GlassmorphismTheme.h3Style,
                        ),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) => Text(
                            '\$${state.getCartPriceTotal()}',
                            style: GlassmorphismTheme.h2Style.copyWith(
                              color: GlassmorphismTheme.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Payment Form Card
                  GlassCard(
                    margin:
                        const EdgeInsets.only(bottom: GlassmorphismTheme.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Details',
                          style: GlassmorphismTheme.h2Style.copyWith(
                            color: GlassmorphismTheme.gold,
                          ),
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),

                        // Card Number Input
                        GlassInput(
                          hintText: 'Card Number',
                          prefixIcon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          autofillHints: const [AutofillHints.creditCardNumber],
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),

                        // Expiry and CVV Row
                        Row(
                          children: [
                            Expanded(
                              child: GlassInput(
                                hintText: 'MM/YY',
                                prefixIcon: Icons.calendar_today,
                                keyboardType: TextInputType.datetime,
                                autofillHints: const [
                                  AutofillHints.creditCardExpirationDate
                                ],
                              ),
                            ),
                            const SizedBox(width: GlassmorphismTheme.md),
                            Expanded(
                              child: GlassInput(
                                hintText: 'CVV',
                                prefixIcon: Icons.lock,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                autofillHints: const [
                                  AutofillHints.creditCardSecurityCode
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),

                        // Cardholder Name
                        GlassInput(
                          hintText: 'Cardholder Name',
                          prefixIcon: Icons.person,
                          autofillHints: const [AutofillHints.creditCardName],
                        ),
                      ],
                    ),
                  ),

                  // Address Form
                  GlassCard(
                    margin:
                        const EdgeInsets.only(bottom: GlassmorphismTheme.md),
                    child: AddressForm(profile: widget.profile),
                  ),

                  // Profile Payment Card
                  BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    return GlassCard(
                      margin:
                          const EdgeInsets.only(bottom: GlassmorphismTheme.md),
                      child: ProfilePaymentCard(
                          profile: state.profile!, heightFactor: .2),
                    );
                  }),

                  // Points Widget
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state.status == ProfileStatus.hybridPayment ||
                          state.status == ProfileStatus.hybridPaymentFunds ||
                          state.status == ProfileStatus.hybridPaymentPoints) {
                        return GlassCard(
                          margin: const EdgeInsets.only(
                              bottom: GlassmorphismTheme.md),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                            child: EnterPointsWidget(
                              availablePoints: state.profile!.altruePoints!,
                              shirts: context.read<CartBloc>().state.cart,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  // Security Badge
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: GlassmorphismTheme.gold.withOpacity(0.7),
                          size: 16,
                        ),
                        const SizedBox(width: GlassmorphismTheme.xs),
                        Text(
                          'Secure Payment • SSL Encrypted',
                          style: GlassmorphismTheme.captionStyle.copyWith(
                            color: GlassmorphismTheme.gold.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.lg),

                  // Payment Buttons
                  Column(
                    children: [
                      BlocListener<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                          if (state.status == ProfileStatus.paymentAccepted) {
                            context.read<CartBloc>().add(PaymentAccepted());
                            context.go('/rewardhome/thankyou',
                                extra:
                                    ThankYouScreenArguments(isPurchase: true));
                          }
                        },
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state.status == ProfileStatus.confirmingOrder) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: GlassmorphismTheme.gold,
                                ),
                              );
                            }
                            return Column(
                              children: [
                                GlassButton(
                                  text: 'Pay With Points',
                                  variant: GlassButtonVariant.secondary,
                                  isFullWidth: true,
                                  onPressed: () async {
                                    if (context
                                            .read<ProfileBloc>()
                                            .state
                                            .status !=
                                        ProfileStatus.updating) {
                                      context.read<ProfileBloc>().add(
                                          PayWithPoints(
                                              shirts: context
                                                  .read<CartBloc>()
                                                  .state
                                                  .cart));
                                    }
                                  },
                                ),
                                const SizedBox(height: GlassmorphismTheme.sm),
                                GlassButton(
                                  text: 'Pay With Funds',
                                  variant: GlassButtonVariant.primary,
                                  isFullWidth: true,
                                  onPressed: () async {
                                    ProfileBloc profileBloc =
                                        context.read<ProfileBloc>();
                                    try {
                                      await Stripe.instance
                                          .presentPaymentSheet();
                                      await Future.delayed(
                                          const Duration(seconds: 9));
                                      profileBloc.add(ConfirmOrder());
                                    } catch (e) {
                                      print(
                                          'Error presenting payment sheet: $e');
                                    }
                                  },
                                ),
                                const SizedBox(height: GlassmorphismTheme.sm),
                                GlassButton(
                                  text: 'Pay With Points & Funds',
                                  variant: GlassButtonVariant.glass,
                                  isFullWidth: true,
                                  onPressed: () async {
                                    context.read<ProfileBloc>().add(
                                        HybridPayment(
                                            shirts: items, pointAmount: null));
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context,
      {required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: GlassmorphismTheme.sm, bottom: GlassmorphismTheme.md),
      child: GlassButton(
        text: text,
        variant: GlassButtonVariant.primary,
        isFullWidth: true,
        onPressed: onPressed,
      ),
    );
  }
}
