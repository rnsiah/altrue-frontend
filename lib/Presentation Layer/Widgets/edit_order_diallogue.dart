import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_size_model.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

class EditOrderDialogue extends StatefulWidget {
  final Shirt? shirt;
  final CartBloc? cartBloc;
  final ShirtOrderBlocBloc? shirtOrderBlocBloc;
  const EditOrderDialogue({
    required this.cartBloc,
    required this.shirt,
    required this.shirtOrderBlocBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<EditOrderDialogue> createState() => _EditOrderDialogueState();
}

class _EditOrderDialogueState extends State<EditOrderDialogue> {
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
    List<String> colo = List.from(colorList.reversed);
    return colo;
  }

  String _selectedSize = 'Choose';
  String _selectedColor = 'Black';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusXl),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: GlassCard(
        opacity: 0.15,
        borderRadius: GlassmorphismTheme.radiusXl,
        padding:
            const EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
        margin: const EdgeInsets.only(top: 45),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusLg),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.shirt!.shirtImage!),
                ),
              ),
            ),
            const SizedBox(height: GlassmorphismTheme.md),
            Text(
              widget.shirt!.name!,
              style: TextStyle(
                color: isDark
                    ? GlassmorphismTheme.textPrimary
                    : GlassmorphismTheme.textPrimary,
                fontSize: GlassmorphismTheme.h2Size,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  children: [
                    // ColorAndSize(shirt: widget.shirt),
                    const SizedBox(
                      height: 25,
                    ),

                    DropdownButton<String>(
                        value: _selectedColor,
                        items: shirtColors(widget.shirt!).map((e) {
                          return DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedColor = value!;
                          });
                          context.read<ShirtOrderBlocBloc>().add(
                              ShirtColorChange(
                                  shirt: widget.shirt!,
                                  shirtColor: ShirtColor(
                                      color: value.toString(),
                                      id: 20,
                                      hex: value.toString())));
                          print(value.toString());
                        }),

                    const Text(
                      'Choose Quantity',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 120,
                        height: 70,
                        child: Center(
                            child: Row(
                          children: [
                            IconButton(
                                onPressed: () => context
                                    .read<ShirtOrderBlocBloc>()
                                    .add(const ShirtQuantityDecrement()),
                                icon: const Icon(Icons.remove)),
                            BlocBuilder<ShirtOrderBlocBloc,
                                ShirtOrderBlocState>(builder: (context, state) {
                              if (state.quantity <= 1) {
                                return const Text('1');
                              }
                              return Text(state.quantity.toString());
                            }),
                            IconButton(
                                onPressed: () => context
                                    .read<ShirtOrderBlocBloc>()
                                    .add(const ShirtQuantityIncrement()),
                                icon: const Icon(Icons.add))
                          ],
                        ))),

                    const SizedBox(
                      height: 25,
                    ),
                    DropdownButton<String>(
                        value: _selectedSize,
                        itemHeight: 50,
                        items: shirtSizes(widget.shirt!).map((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          print('Shirt Size has been changed to $value');
                          setState(() {
                            _selectedSize = value!;
                            widget.shirtOrderBlocBloc!.add(ShirtSizeChange(
                                shirtSize: ShirtSize(id: 2, size: value)));
                          });
                        })

                    // ShirtSizePicker(shirt: widget.shirt)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
