import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/atrocity_repositories.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

class NonprofitAtrocityShowcase extends StatelessWidget {
  final NonProfit nonprofit;
  final Profile profile;

  const NonprofitAtrocityShowcase(
      {Key? key, required this.nonprofit, required this.profile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    AtrocityRepository atrocityRepository = AtrocityRepository();
    return ListView.builder(
        itemCount: nonprofit.atrocity!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Atrocity atrocity = await atrocityRepository
                  .getAtrocity(nonprofit.atrocity![index].id!);
              Navigator.of(context).pushNamed('/atrocityView',
                  arguments: AtrocityDetailArguments(
                      atrocity: atrocity, profile: profile));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                nonprofit.atrocity![index].imageUrl!))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(nonprofit.atrocity![index].title),
                )
              ],
            ),
          );
        });
  }
}
