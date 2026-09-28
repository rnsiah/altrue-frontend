import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import '../../../theme/glassmorphism_theme.dart';
import '../../../widgets/glass/glass_card.dart';
import '../../../widgets/glass/glass_button.dart';

class ShirtSizePicker extends StatefulWidget {
  final Shirt shirt;
  const ShirtSizePicker({Key? key, required this.shirt}) : super(key: key);

  @override
  _ShirtSizePickerState createState() => _ShirtSizePickerState();
}

class _ShirtSizePickerState extends State<ShirtSizePicker> {
  List<String> shirtSizes(Shirt shirt) {
    List<String> titles = [];
    for (var project in shirt.shirtSizes!) {
      titles.add(project.size);
    }
    return titles;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sizes = shirtSizes(widget.shirt);

    return GlassCard(
      height: 200,
      width: 150,
      borderRadius: GlassmorphismTheme.radiusLg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select Size',
            style: isDark
                ? GlassmorphismTheme.h3Style
                : GlassmorphismTheme.h3Style,
          ),
          SizedBox(height: GlassmorphismTheme.md),
          ...sizes
              .map((size) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: GlassmorphismTheme.sm),
                    child: GlassButton(
                      text: size,
                      variant: GlassButtonVariant.glass,
                      isFullWidth: true,
                      horizontalPadding: GlassmorphismTheme.md,
                      verticalPadding: GlassmorphismTheme.sm,
                      onPressed: () {
                        // Size selection logic would go here
                        // This would typically be handled by a bloc event
                      },
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
