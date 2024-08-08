import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/edit_order_diallogue.dart';

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
       if(state.status== ProfileStatus.paymentSheetInitalized){
        Navigator.of(context).popAndPushNamed('/payment');
       }
      },
      child: Container(
        color: Colors.black87,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 20, top: 15),
                child: Text(
                  'Your Current Order',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 24,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
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
                        child: Card(
                          color: Colors.black54,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.black)),
                          child: ListTile(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return EditOrderDialogue(
                                        cartBloc:
                                            context.read<CartBloc>(),
                                        shirt:
                                            widget.cartList[index].shirt,
                                        shirtOrderBlocBloc: context
                                            .read<ShirtOrderBlocBloc>());
                                  });
                            },
                            leading: Image(
                              image: NetworkImage(
                                  state.cart[index].shirt.shirtImage!),
                            ),
                            title: Text(
                              state.cart[index].shirt.name!,
                              style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Qty: ${state.cart[index].quantity}',
                                    style: const TextStyle(
                                        color: Colors.amber)),
                                Text('Size: ${state.cart[index].size.size}',
                                    style: const TextStyle(
                                        color: Colors.amber)),
                                Text(
                                  'Color: ${state.cart[index].color.color}',
                                  style:
                                      const TextStyle(color: Colors.amber),
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
                    padding: EdgeInsets.only(bottom: 15, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Point Cost:',
                          style: TextStyle(color: Colors.amber, fontSize: 22),
                        ),
                        Text(state.getCartPointTotal(),
                            style: const TextStyle(
                                color: Colors.amber, fontSize: 22)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, right: 14),
                    child: Row(
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
                                'notUpdate',
                                style: TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),
                        const Text(
                          'Total:',
                          style: TextStyle(color: Colors.amber, fontSize: 22),
                        ),
                        Text(
                          '\$${state.getCartPriceTotal()}',
                          style: const TextStyle(
                              color: Colors.amber, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        elevation: 12,
                        color: Colors.amber,
                        child: const Text('Check Out Now'),
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

                          // Navigator.of(context).pushNamed('/payment',
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
                    ),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
