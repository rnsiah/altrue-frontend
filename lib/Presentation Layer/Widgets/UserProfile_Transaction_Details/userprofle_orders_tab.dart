import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:intl/intl.dart';


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
          final orderDate = DateTime.parse(order.orderDate);
          final formattedDate = DateFormat('MMMM d, yyyy').format(orderDate);
        
          return ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Card(
              child: ExpansionTile(
                
                collapsedBackgroundColor: Colors.black,
                collapsedTextColor: Colors.amber,
                title: Text('order #${order.id.toString()}'),
                subtitle: Text('Date ordered: $formattedDate'),
                children: [
                  for (var item in order.shirts)
                    Card(
                      child: Image(
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
