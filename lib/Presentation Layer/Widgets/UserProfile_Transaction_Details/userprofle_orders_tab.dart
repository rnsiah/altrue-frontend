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
            final orderDate = order.orderDate != null 
              ? DateTime.parse(order.orderDate!) 
              : DateTime.now();
          final formattedDate = DateFormat('MMMM d, yyyy').format(orderDate);
        
          return ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 15,  vertical: 10),
              elevation: 5,
              child: ExpansionTile(
                
                collapsedBackgroundColor: Colors.black,
                collapsedTextColor: Colors.amber,
                title: Text('order #${order.id.toString()}',
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16, color: Colors.amber)),
                subtitle: Text('Date ordered: $formattedDate',
                                  style: const TextStyle(color: Colors.white70),
),backgroundColor: Colors.black,
textColor: Colors.white,
iconColor: Colors.amber,
                children: [
                  for (var item in order.shirts)
                    Card(elevation: 3,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                item.shirt.variations!
                                .firstWhere((variation)=> variation.color.color == item.color.color,
                                orElse: () => item.shirt.variations!.first,
                                ).image
                              
                                
                              ),
                              
                            ),
                            SizedBox(height: 10,),
                            Text(item.shirt.name?? 'Unknown Item',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Price: \$${item.shirt.price!.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),

                                Row(
                                  children: [
                                    Text("Color:",style: TextStyle(fontSize: 14, color: Colors.black54),),
                                    Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Color(int.parse(item.color.hex)),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
              ),
                                  SizedBox(height: 10,),
                                  ],
                                ),
                                
                              ],
                            )
                          ],
                        ),
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
