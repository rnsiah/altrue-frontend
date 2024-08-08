import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

import '../../../Data Layer/Repositories/shirt_repository.dart';

// ignore: must_be_immutable
class AtrocityShirtShowcase extends StatelessWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityShirtShowcase(
      {super.key, required this.profile, required this.atrocity});

  @override
  Widget build(BuildContext context) {
    ShirtRepository shirtRepository = ShirtRepository();
    return GridView.builder(
      itemCount: atrocity.shirtList!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 12,
        crossAxisSpacing: 27,
        childAspectRatio: .70,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            if (atrocity.shirtList != null) {
              Shirt shirt = await shirtRepository
                  .fetchShirt(atrocity.shirtList![index].id!);

              Navigator.of(context).pushNamed('/ShirtDetail',
                  arguments:
                      ShirtDetailArguments(profile: profile, shirt: shirt));
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Image(
                    image: NetworkImage(atrocity.shirtList![index].shirtImage!,
                        scale: .7)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  atrocity.shirtList![index].name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(atrocity.shirtList![index].category!.name!)
            ],
          ),
        );
      },
    );
  }
}
