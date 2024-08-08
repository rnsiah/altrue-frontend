import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';

class CartIcon extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  final int notificationCount;

  const CartIcon({
    Key? key,
    this.onTap,
    required this.text,
    required this.iconData,
    required this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CartBloc>(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(iconData),
                  Text(text, overflow: TextOverflow.ellipsis),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  alignment: Alignment.center,
                  child: Text(
                    '$notificationCount',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
