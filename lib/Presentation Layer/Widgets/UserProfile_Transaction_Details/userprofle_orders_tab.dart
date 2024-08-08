import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class UserProfileOrdersTab extends StatelessWidget {
  final Profile profile;
  const UserProfileOrdersTab({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: profile.orders!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            return SizedBox(
              height: 300,
              child: ListTile(
                  leading: Image(
                    image: NetworkImage(profile
                        .orders![index].shirts[index].shirt.shirtImage
                        .toString()),
                  ),
                  // trailing: Text(state
                  //     .completedOrders[index].shirts[index]
                  //     ),
                  title: Text(profile.orders![index].shirts[index].shirt.name
                      .toString())),
            );
          }),
    );
  }
}
