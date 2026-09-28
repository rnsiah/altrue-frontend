import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/edit_order_diallogue.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

import '../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';

class CartBottomScreen extends StatefulWidget {
  final List<OrderItem> cartList;
  final ScrollController controller;
  const CartBottomScreen({
    Key? key,
    required this.cartList,
    required this.controller,
  }) : super(key: key);

  @override
  State<CartBottomScreen> createState() => _CartBottomScreenState();
}

class _CartBottomScreenState extends State<CartBottomScreen> {
  ScrollController controller = ScrollController();

  double getCartTotal() {
    double total = 0;
    for (OrderItem item in widget.cartList) {
      double itemOrderTotal = item.shirt.price! * item.quantity;
      total += itemOrderTotal;
    }
    return double.parse((total).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.paymentSheetInitalized) {
          context.go('/userProfile/payment');
        }
      },
      child: ClipRRect(
        child: SafeArea(
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? GlassmorphismTheme.darkPrimary
                : GlassmorphismTheme.darkPrimary,
            // height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, bottom: 0, top: 15),
                    child: GlassCard(
                      opacity: 0.15,
                      borderRadius: GlassmorphismTheme.radiusXl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GlassmorphismTheme.lg,
                          vertical: GlassmorphismTheme.md,
                        ),
                        child: Text(
                          'Your Current Order',
                          style: TextStyle(
                            color: GlassmorphismTheme.gold,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 300,
                    child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                      return ListView.builder(
                        controller: widget.controller,
                        scrollDirection: Axis.vertical,
                        itemExtent: 90,
                        itemCount: state.cart.length,
                        itemBuilder: (context, index) => Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.amber,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    onPressed: (context) {
                                      context.read<CartBloc>().add(
                                          CartItemDeleted(
                                              item: state.cart[index]));
                                    }),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7.0, right: 8),
                            child: GlassCard(
                              opacity: 0.1,
                              borderRadius: GlassmorphismTheme.radiusLg,
                              hasGoldBorder: true,
                              child: ListTile(
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return EditOrderDialogue(
                                            cartBloc: context.read<CartBloc>(),
                                            shirt: widget.cartList[index].shirt,
                                            shirtOrderBlocBloc: context
                                                .read<ShirtOrderBlocBloc>());
                                      });
                                },
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      GlassmorphismTheme.radiusSm),
                                  child: Image(
                                    image: NetworkImage(
                                        state.cart[index].shirt.shirtImage!),
                                  ),
                                ),
                                title: Text(
                                  state.cart[index].shirt.name!,
                                  style: TextStyle(
                                      color: GlassmorphismTheme.gold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: GlassmorphismTheme.h3Size),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Qty: ${state.cart[index].quantity}',
                                        style: TextStyle(
                                            color: GlassmorphismTheme
                                                .textSecondary,
                                            fontSize: GlassmorphismTheme
                                                .captionSize)),
                                    Text('Size: ${state.cart[index].size.size}',
                                        style: TextStyle(
                                            color: GlassmorphismTheme
                                                .textSecondary,
                                            fontSize: GlassmorphismTheme
                                                .captionSize)),
                                    Text(
                                      'Color: ${state.cart[index].color.color}',
                                      style: TextStyle(
                                          color:
                                              GlassmorphismTheme.textSecondary,
                                          fontSize:
                                              GlassmorphismTheme.captionSize),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
                BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 14),
                        child: GlassCard(
                          opacity: 0.1,
                          borderRadius: GlassmorphismTheme.radiusLg,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: GlassmorphismTheme.lg,
                              vertical: GlassmorphismTheme.md,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Point Cost:',
                                  style: TextStyle(
                                    color: GlassmorphismTheme.gold,
                                    fontSize: GlassmorphismTheme.h3Size,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: GlassmorphismTheme.sm),
                                Text(
                                  state.getCartPointTotal(),
                                  style: TextStyle(
                                    color: GlassmorphismTheme.gold,
                                    fontSize: GlassmorphismTheme.h3Size,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 14),
                        child: GlassCard(
                          opacity: 0.1,
                          borderRadius: GlassmorphismTheme.radiusLg,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: GlassmorphismTheme.lg,
                              vertical: GlassmorphismTheme.md,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BlocListener<ProfileBloc, ProfileState>(
                                  listener: (context, state) {
                                    if (state.paymentIntentData != null) {
                                      print('HAs some damn data');
                                    }
                                  },
                                  child: BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                      print(state.status);

                                      return const Text(
                                        '',
                                        style: TextStyle(color: Colors.white),
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  'Total:',
                                  style: TextStyle(
                                    color: GlassmorphismTheme.gold,
                                    fontSize: GlassmorphismTheme.h3Size,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: GlassmorphismTheme.sm),
                                Text(
                                  '\$${state.getCartPriceTotal()}',
                                  style: TextStyle(
                                    color: GlassmorphismTheme.gold,
                                    fontSize: GlassmorphismTheme.h3Size,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, bottom: 20),
                        child: GlassButton(
                          text: 'Check Out Now',
                          variant: GlassButtonVariant.primary,
                          isFullWidth: true,
                          height: 60,
                          borderRadius: GlassmorphismTheme.radiusXl,
                          onPressed: () async {
                            context.read<ProfileBloc>().add(
                                CreatePaymentIntentForPurchase(
                                    amount: (state.getCartPriceTotal() * 100)
                                        .toInt(),
                                    shirts: state.cart));

                            if (context
                                    .read<ProfileBloc>()
                                    .state
                                    .paymentIntentData !=
                                null) {
                              print('intent was created had to wait ');
                            } else {
                              print('this some bullshit');
                            }

                            // context.go('/payment',
                            //     arguments: context.read<ProfileBloc>().state);
                            // print(state.paymentIntentData);
                            // widget.profilebloc.add(CreatePaymentIntentForPurchase(
                            //     amount: (state.getCartPriceTotal() * 100).toInt(),
                            //     shirts: state.cart));

                            // context
                            //     .read<CartBloc>()
                            //     .add(const CartSubmitted());
                          },
                        ),
                      )
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
