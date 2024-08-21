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
        itemCount: profile.orders!.reversed.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, int index) {
          final order = profile.orders!.reversed
              .toList()[index]; // Access the reversed order
          return ClipRRect(
            borderRadius: BorderRadius.circular(46),
            child: Card(
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.black,
                collapsedTextColor: Colors.amber,
                title: Text('order #${order.id.toString()}'),
                subtitle: Text(order.orderDate.toString()),
                children: [
                  for (var item in order.shirts)
                    ListTile(
                      title: Image(
                        image: NetworkImage(item.shirt.shirtImage!),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
