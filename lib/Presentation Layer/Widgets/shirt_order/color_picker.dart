import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import '../../../theme/glassmorphism_theme.dart';
import '../../../widgets/glass/glass_card.dart';
import '../../../widgets/glass/glass_button.dart';

class PickColorWidgett extends StatefulWidget {
  final List<String> shirtColors;
  final Shirt shirt;
  final String selectedColor;
  final ShirtOrderBlocBloc shirtOrderBlocBloc;
  final ShirtOrderBlocEvent shirtOrderBlocEvent;
  const PickColorWidgett(
      {super.key,
      required this.shirtColors,
      required this.shirt,
      required this.shirtOrderBlocBloc,
      required this.selectedColor,
      required this.shirtOrderBlocEvent});

  @override
  State<PickColorWidgett> createState() => _PickColorWidgettState();
}

class _PickColorWidgettState extends State<PickColorWidgett> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String theColor = widget.shirt.variations![0].color.color;

    return BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
      builder: (context, state) {
        return GlassCard(
          borderRadius: GlassmorphismTheme.radiusLg,
          hasGoldBorder: true,
          padding: const EdgeInsets.all(GlassmorphismTheme.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Color',
                style: isDark
                    ? GlassmorphismTheme.h3Style
                    : GlassmorphismTheme.h3Style,
              ),
              SizedBox(height: GlassmorphismTheme.md),
              Wrap(
                spacing: GlassmorphismTheme.sm,
                runSpacing: GlassmorphismTheme.sm,
                children: widget.shirtColors.map((colorName) {
                  final isSelected = theColor == colorName;
                  return GlassButton(
                    text: colorName,
                    variant: isSelected
                        ? GlassButtonVariant.primary
                        : GlassButtonVariant.glass,
                    onPressed: () {
                      setState(() {
                        theColor = colorName;
                        widget.shirtOrderBlocBloc
                            .add(widget.shirtOrderBlocEvent);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
