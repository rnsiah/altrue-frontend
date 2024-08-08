import 'package:flutter/material.dart';

import '../../Data Layer/Models/post_model.dart';
import '../../Data Layer/Models/user_model.dart';

class NewPostsScreen extends StatefulWidget {
  final Profile profile;
  final List<Post> postList;
  const NewPostsScreen({super.key, required this.profile, required this.postList});

  @override
  State<NewPostsScreen> createState() => _NewPostsScreenState();
}

class _NewPostsScreenState extends State<NewPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('New Posts'),),
        body: ListView.builder(
                      itemCount: widget.postList.length,
                      itemBuilder: (context, index) =>  ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.postList[index].created_by.profilePicture!.url),
                ),
                title: Text(widget.postList[index].created_by.username, style: const TextStyle(color: Colors.amber, fontSize: 22),),
                subtitle: Text(widget.postList[index].body, style: const TextStyle(color: Colors.white),),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white,),
                  onPressed: () {
                    // Handle the like button press
                  },
                ),
              ),),
    );
  }
}

// Widget buildPost(Post post) {
  
// }