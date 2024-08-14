import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class UserProfileDonationsTab extends StatelessWidget {
  final Profile profile;
  const UserProfileDonationsTab({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: profile.userdonations!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            // ignore: iterable_contains_unrelated_type
            final bool hasAtro = profile.userdonations!
                .contains(profile.userdonations![index].atrocity);
            return SizedBox(
                height: 80,
                child: ListTile(
                  leading: !hasAtro
                      ? Image (
                          image: NetworkImage(profile
                              .userdonations![index].nonprofit!.logo
                              .toString()),
                        )
                      : Container(),
                  subtitle: hasAtro
                      ? Text(
                          'Altrue Category: ${profile.userdonations![index].atrocity!.category[0].name}')
                      : const Text('Alrue NonProfit'),

                  // trailing: Text(state
                  //     .completedOrders[index].shirts[index]
                  //     ),
                  title: hasAtro
                      ? Text(profile.userdonations![index].atrocity!.title)
                      : Text(profile.userdonations![index].nonprofit!.name
                          .toString()),
                  trailing: Text(profile.userdonations![index].dollarAmount),
                ));
          }),
    );
  }
}
