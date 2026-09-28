import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_size_model.dart';
import 'package:photo_view/photo_view.dart';
import '../../../Data Layer/Models/shirt_variation_model.dart';
import '../../../theme/glassmorphism_theme.dart';
import '../../../widgets/glass/glass_card.dart';
import '../../../widgets/glass/glass_button.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
        margin: const EdgeInsets.all(GlassmorphismTheme.md),
        borderRadius: GlassmorphismTheme.radius2Xl,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: GlassmorphismTheme.lg),
                    child: Text(
                      widget.shirt.name!,
                      style: isDark
                          ? GlassmorphismTheme.h1Style
                          : GlassmorphismTheme.h1Style,
                    ),
                  ),
                  SizedBox(height: GlassmorphismTheme.md),
                  Expanded(
                    child: Row(
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
                                return GlassCard(
                                  borderRadius: GlassmorphismTheme.radiusXl,
                                  hasGoldBorder:
                                      state.status == ShirtColorStatus.Changing,
                                  child: Container(
                                    transform: Matrix4.translationValues(
                                        state.status ==
                                                ShirtColorStatus.Changing
                                            ? -22
                                            : -14,
                                        0,
                                        0),
                                    width: 250,
                                    height: 250,
                                    child: PhotoView(
                                      backgroundDecoration: BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      imageProvider: NetworkImage(
                                          state.status ==
                                                  ShirtColorStatus.Changing
                                              ? state.shirtImageUrl!
                                              : widget.shirt.shirtImage!),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        GlassCard(
                          borderRadius: GlassmorphismTheme.radiusLg,
                          padding: const EdgeInsets.all(GlassmorphismTheme.md),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Color',
                                style: isDark
                                    ? GlassmorphismTheme.h3Style
                                    : GlassmorphismTheme.h3Style,
                              ),
                              SizedBox(height: GlassmorphismTheme.sm),
                              GlassCard(
                                borderRadius: GlassmorphismTheme.radiusSm,
                                hasGoldBorder: true,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: GlassmorphismTheme.sm,
                                  vertical: GlassmorphismTheme.xs,
                                ),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(
                                      GlassmorphismTheme.radiusSm),
                                  dropdownColor: isDark
                                      ? GlassmorphismTheme.darkSecondary
                                      : GlassmorphismTheme.darkSecondary,
                                  focusColor: GlassmorphismTheme.gold,
                                  value: _selectedColor,
                                  underline: SizedBox(),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: isDark
                                        ? GlassmorphismTheme.textPrimary
                                        : GlassmorphismTheme.textPrimary,
                                  ),
                                  items: shirtColors(widget.shirt).map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: isDark
                                            ? GlassmorphismTheme.bodyStyle
                                            : GlassmorphismTheme.bodyStyle,
                                      ),
                                    );
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
                                  },
                                ),
                              ),
                              SizedBox(height: GlassmorphismTheme.md),
                              Text(
                                'Qty',
                                style: isDark
                                    ? GlassmorphismTheme.h3Style
                                    : GlassmorphismTheme.h3Style,
                              ),
                              SizedBox(height: GlassmorphismTheme.xs),
                              GlassCard(
                                borderRadius: GlassmorphismTheme.radiusSm,
                                hasGoldBorder: false,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: GlassmorphismTheme.sm,
                                  vertical: GlassmorphismTheme.xs,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GlassIconButton(
                                      icon: Icons.remove,
                                      onPressed: () => context
                                          .read<ShirtOrderBlocBloc>()
                                          .add(const ShirtQuantityDecrement()),
                                      variant: GlassButtonVariant.glass,
                                      size: 32,
                                    ),
                                    SizedBox(width: GlassmorphismTheme.md),
                                    BlocBuilder<ShirtOrderBlocBloc,
                                            ShirtOrderBlocState>(
                                        builder: (context, state) {
                                      return Text(
                                        state.quantity.toString(),
                                        style: isDark
                                            ? GlassmorphismTheme.h2Style
                                            : GlassmorphismTheme.h2Style,
                                      );
                                    }),
                                    SizedBox(width: GlassmorphismTheme.md),
                                    GlassIconButton(
                                      icon: Icons.add,
                                      onPressed: () => context
                                          .read<ShirtOrderBlocBloc>()
                                          .add(const ShirtQuantityIncrement()),
                                      variant: GlassButtonVariant.glass,
                                      size: 32,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: GlassmorphismTheme.md),
                              Text(
                                'Size',
                                style: isDark
                                    ? GlassmorphismTheme.h3Style
                                    : GlassmorphismTheme.h3Style,
                              ),
                              SizedBox(height: GlassmorphismTheme.xs),
                              GlassCard(
                                borderRadius: GlassmorphismTheme.radiusSm,
                                hasGoldBorder: true,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: GlassmorphismTheme.sm,
                                  vertical: GlassmorphismTheme.xs,
                                ),
                                child: DropdownButton<String>(
                                  dropdownColor: isDark
                                      ? GlassmorphismTheme.darkSecondary
                                      : GlassmorphismTheme.darkSecondary,
                                  borderRadius: BorderRadius.circular(
                                      GlassmorphismTheme.radiusSm),
                                  value: _selectedSize,
                                  underline: SizedBox(),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: isDark
                                        ? GlassmorphismTheme.textPrimary
                                        : GlassmorphismTheme.textPrimary,
                                  ),
                                  itemHeight: 50,
                                  items: shirtSizes(widget.shirt).map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: isDark
                                            ? GlassmorphismTheme.bodyStyle
                                            : GlassmorphismTheme.bodyStyle,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSize = value!;
                                      shirtBlocOrder.add(ShirtSizeChange(
                                          shirtSize:
                                              ShirtSize(id: 1, size: value)));
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: GlassmorphismTheme.lg),
                  BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
                    builder: (context, state) {
                      return Text(
                        '\$${(widget.shirt.price! * state.quantity).toStringAsFixed(2)}',
                        style: isDark
                            ? GlassmorphismTheme.heroStyle.copyWith(
                                color: GlassmorphismTheme.gold,
                                fontSize: 28,
                              )
                            : GlassmorphismTheme.heroStyle.copyWith(
                                color: GlassmorphismTheme.gold,
                                fontSize: 28,
                              ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GlassmorphismTheme.lg,
                      vertical: GlassmorphismTheme.md,
                    ),
                    child: GlassButton(
                      text: 'Add To Cart',
                      variant: GlassButtonVariant.primary,
                      isFullWidth: true,
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
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  void _showSnackbar(BuildContext context, String message) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final snackbar = SnackBar(
      backgroundColor: isDark
          ? GlassmorphismTheme.darkSecondary
          : GlassmorphismTheme.darkSecondary,
      content: Text(
        message,
        style: TextStyle(
          color: GlassmorphismTheme.gold,
          fontWeight: FontWeight.w600,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
      ),
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
