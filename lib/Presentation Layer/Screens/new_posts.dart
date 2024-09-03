import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/feed_bloc/bloc/feed_bloc.dart';
import '../../Data Layer/Models/feed_entry_model.dart';
import '../../Data Layer/Models/user_model.dart';

class NewPostsScreen extends StatefulWidget {
  final Profile profile;

  const NewPostsScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<NewPostsScreen> createState() => _NewPostsScreenState();
}

class _NewPostsScreenState extends State<NewPostsScreen> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('New Posts'),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            return ListView.builder(
              itemCount: state.feedItems.length,
              itemBuilder: (context, index) {
                final item = state.feedItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Card(
                    color: Colors.amber,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: Icon(
                        item.pointAmount != null ? Icons.star : Icons.attach_money,
                        color: Colors.black,
                      ),
                      title: Text(
                        item.pointAmount != null
                            ? '${item.username} accomplished: ${item.requirement}'
                            : '${item.receiverUsername} received a donation',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        item.pointAmount != null
                            ? 'Points earned: ${item.pointAmount}'
                            : 'Amount: \$${item.donationAmount?.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      trailing: Text(
                        item.timestamp?.toLocal().toString() ?? '',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}