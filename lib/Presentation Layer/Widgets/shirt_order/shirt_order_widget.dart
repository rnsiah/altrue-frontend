import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_size_model.dart';
import 'package:photo_view/photo_view.dart';
import '../../../Data Layer/Models/shirt_variation_model.dart';

class ShirtOrderForm extends StatefulWidget {
  final Shirt shirt;
  final CartBloc cartBloc;
  final ShirtOrderBlocBloc shirtOrderBlocBloc;
  const ShirtOrderForm({
    required this.cartBloc,
    required this.shirtOrderBlocBloc,
    required this.shirt,
    Key? key,
  }) : super(key: key);

  @override
  State<ShirtOrderForm> createState() => _ShirtOrderFormState();
}

class _ShirtOrderFormState extends State<ShirtOrderForm> {
  @override
  void initState() {
    super.initState();
  }

  List<String> shirtSizes(Shirt shirt) {
    List<String> titles = [];
    for (var project in shirt.shirtSizes!) {
      titles.add(project.size);
    }
    titles.add('Choose');
    return titles;
  }

  List<String> shirtColors(Shirt shirt) {
    List<String> colorList = [];
    for (var variation in shirt.variations!) {
      colorList.add(variation.color.color);
    }
    List<String> colo = List.from(colorList);
    return colo;
  }

  String _selectedSize = 'Choose';
  String _selectedColor = 'Black';
  bool showVariations = false;

  @override
  Widget build(BuildContext context) {
    final ShirtOrderBlocBloc shirtBlocOrder =
        context.read<ShirtOrderBlocBloc>();
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      height: 700,
      child: BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  widget.shirt.name!,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<ShirtOrderBlocBloc, ShirtOrderBlocState>(
                    listener: (context, state) {
                      if (state is OrderSubmitted) {
                        _showSnackbar(context,
                            'The shirt ${widget.shirt.name} has been added to your cart');
                      }
                    },
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, state) {
                      return BlocBuilder<ShirtOrderBlocBloc,
                          ShirtOrderBlocState>(
                        builder: (context, state) {
                          return Container(
                              transform: Matrix4.translationValues(
                                  state.status == ShirtColorStatus.Changing
                                      ? -22
                                      : -14,
                                  0,
                                  0),
                              width: 250,
                              height: 250,
                              child: PhotoView(
                                backgroundDecoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                imageProvider: NetworkImage(
                                    state.status == ShirtColorStatus.Changing
                                        ? state.shirtImageUrl!
                                        : widget.shirt.shirtImage!),
                              ));
                        },
                      );
                    },
                  ),
                  Container(
                    transform: Matrix4.translationValues(-15, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Color',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                            borderRadius: BorderRadius.circular(8),
                            dropdownColor: Colors.white,
                            focusColor: Colors.amber,
                            value: _selectedColor,
                            items: shirtColors(widget.shirt).map((e) {
                              return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(color: Colors.black),
                                  ));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedColor = value!;
                              });
                              context
                                  .read<ShirtOrderBlocBloc>()
                                  .add(ShirtColorChange(
                                    shirt: widget.shirt,
                                    shirtColor: ShirtColor(
                                        color: _selectedColor,
                                        hex: value.toString()),
                                  ));
                            }),
                        const Text(
                          'Qty',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                            height: 70,
                            child: Center(
                                child: Row(
                              children: [
                                IconButton(
                                    color: Colors.black,
                                    onPressed: () => context
                                        .read<ShirtOrderBlocBloc>()
                                        .add(const ShirtQuantityDecrement()),
                                    icon: const Icon(Icons.remove)),
                                BlocBuilder<ShirtOrderBlocBloc,
                                        ShirtOrderBlocState>(
                                    builder: (context, state) {
                                  if (state.quantity <= 1) {
                                    return const Text(
                                      '1',
                                      style: TextStyle(color: Colors.black),
                                    );
                                  }
                                  return Text(
                                    state.quantity.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  );
                                }),
                                IconButton(
                                    onPressed: () => context
                                        .read<ShirtOrderBlocBloc>()
                                        .add(const ShirtQuantityIncrement()),
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))
                              ],
                            ))),
                        const Text(
                          'Size',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            value: _selectedSize,
                            itemHeight: 50,
                            items: shirtSizes(widget.shirt).map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSize = value!;
                                shirtBlocOrder.add(ShirtSizeChange(
                                    shirtSize: ShirtSize(id: 1, size: value)));
                              });
                            })
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
                builder: (context, state) {
                  return Text(
                    '\$${(widget.shirt.price! * state.quantity).toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MaterialButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        context
                            .read<ShirtOrderBlocBloc>()
                            .add(ShirtOrderSubmitted(
                              color: shirtBlocOrder.state.color!,
                              shirtId: widget.shirt.id!,
                              quantity: shirtBlocOrder.state.quantity,
                              shirt: widget.shirt,
                              size: shirtBlocOrder.state.size!,
                            ));
                        widget.cartBloc.add(CartBeingLoaded());
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          message,
          style: const TextStyle(color: Colors.amber),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
