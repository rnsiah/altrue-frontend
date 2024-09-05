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
        title: const Text('Feed'),
        leading: IconButton(
          icon: const Icon(Icons.person_search),
          onPressed: () {
            // Navigate to Find My Friends screen
            Navigator.of(context).pushNamed('/findfriends', arguments: widget.profile);
          },
        ),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            return ListView.builder(
              itemCount: state.feedItems.length,
              itemBuilder: (context, index) {
                final item = state.feedItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Card(
                    elevation: 2,
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey[700],
                        child: Icon(
                          item.pointAmount != null
                              ? Icons.star
                              : Icons.attach_money,
                          color: Colors.amber,
                        ),
                      ),
                      title: Text(
                        item.pointAmount != null
                            ? '${item.username} completed: ${item.requirement}'
                            : '${item.receiverUsername} received a donation',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            item.pointAmount != null
                                ? 'Points earned: ${item.pointAmount}'
                                : 'Donation: \$${item.donationAmount?.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.amber[200],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.timestamp?.toLocal().toString() ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.all(12.0),
                      trailing: Icon(
                        item.isPromotion != null && item.isPromotion!
                            ? Icons.local_offer
                            : Icons.arrow_forward_ios,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                      onTap: () {
                        // Show more details on tap
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}