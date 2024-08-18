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
        itemBuilder: (context, int index){
          final order = profile.orders![index];
          return Card(
            child: ExpansionTile(
              title: Text('order #1'),
              children: [
                for (var item in order.shirts)
                ListTile(
                  title: Image(image: NetworkImage(
                    item.shirt.shirtImage!
                  ),),
                )
              ],
            ),
          );     
        },
        ),
    );
  }
}
