import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import '../../Data Layer/Models/atrocity_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Routers/functionality_router.dart';

class AtrocityBox extends StatelessWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityBox({
    required this.profile,
    required this.atrocity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<AtrocityBlocBloc>()
            .add(AtrocityItemFteched(atrocity: atrocity));
        Navigator.of(context).pushNamed('/atrocityView',
            arguments:
                AtrocityDetailArguments(atrocity: atrocity, profile: profile));
      },
      child: atrocity.id == 2 || atrocity.id == 4
          ? _buildSpecialContainer(context)
          : _buildStandardContainer(context),
    );
  }

  Widget _buildSpecialContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3))
        ],
        image: DecorationImage(
            colorFilter:
                const ColorFilter.mode(Colors.yellow, BlendMode.darken),
            image: NetworkImage(atrocity.imageUrl!),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: _buildTextWithSizeAdjustment(context, atrocity.title),
      ),
    );
  }

  Widget _buildStandardContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3))
        ],
        image: DecorationImage(
            colorFilter: const ColorFilter.mode(Colors.green, BlendMode.darken),
            image: NetworkImage(atrocity.imageUrl!),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              transform: Matrix4.translationValues(0, -10, 0),
              child: IconButton(
                iconSize: 40,
                color: Colors.white,
                icon: const Icon(Icons.arrow_circle_up_outlined),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildTextWithSizeAdjustment(context, atrocity.title),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithSizeAdjustment(BuildContext context, String title) {
    final textPainter = TextPainter(
        text: TextSpan(
      text: title,
      style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          backgroundColor: Colors.black.withOpacity(.4)),
    ));
    textPainter.layout(maxWidth: 100); // Assuming a maximum width of 100

    final numberOfLines = textPainter.computeLineMetrics().length;

    return Text(title,
        style: TextStyle(
          fontSize: numberOfLines > 2 // Adjust based on your logic
              ? 16.0 // Set a smaller font size for more than 2 lines
              : 19.0,
          fontWeight: FontWeight.w800,
        ));
  }
}
