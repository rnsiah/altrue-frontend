import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

class NonProfitShirtCase extends StatelessWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NonProfitShirtCase(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShirtRepository shirtRepository = ShirtRepository();

    return GridView.builder(
      itemCount: nonProfit.shirtList!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 12,
          crossAxisSpacing: 27,
          childAspectRatio: .70,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            Shirt shirt = await shirtRepository
                .fetchShirt(nonProfit.shirtList![index].id!);

            Navigator.of(context).pushNamed('/ShirtDetail',
                arguments:
                    ShirtDetailArguments(shirt: shirt, profile: profile));
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Image(
                    image: NetworkImage(nonProfit.shirtList![index].shirtImage!,
                        scale: .7)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  nonProfit.shirtList![index].name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(nonProfit.shirtList![index].category!.name!)
            ],
          ),
        );
      },
    );
  }
}
