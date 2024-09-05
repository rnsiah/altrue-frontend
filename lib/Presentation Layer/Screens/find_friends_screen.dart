import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/manage_followers_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class FindFriends extends StatefulWidget {
  final Profile profile;
  const FindFriends({
    required this.profile,
    Key? key,
  }) : super(key: key);

  @override
  _FindFriendsState createState() => _FindFriendsState();
}


class _FindFriendsState extends State<FindFriends> {
  final ScrollController _scrollController = ScrollController();
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    List<int> list = widget.profile.following!.map((e) => e.id).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Find Friends', style: TextStyle(color: Colors.amber),),
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
               ListTile(
                
                title: const Text('Invite Friends',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: (){
                  print('');
                },
              ),
               ListTile(
                title: Text('Contacts',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const ListTile(
                title: Text(
                  'FaceBook Friends',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Text('Suggested Friends',
                  style: TextStyle(fontSize: 8, color: Colors.blueGrey)),
              BlocBuilder<AllUsersBloc, AllUsersState>(
                builder: (context, state) {
                  if (state.status == ProfileListStatus.successful) {
                    return ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.userList.length,
                        itemBuilder: (context, index) => FriendTile(
                            pro: widget.profile,
                            userRepository: userRepository,
                            prof: state.userList[index]));
                  } else if (state.status == ProfileListStatus.failure) {
                    const Center(
                      child: Text(
                          'Something Went Wrong. Please check your connection'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  const FriendTile({
    Key? key,
    required this.userRepository,
    required this.pro,
    required this.prof,
  }) : super(key: key);

  final UserRepository userRepository;
  final ProfileRepresentation prof;
  final Profile pro;
  @override
  Widget build(BuildContext context) {
    List<int> list = pro.following!.map((e) => e.id).toList();
    return ListTile(
      onTap: () async {
        Profile profile = await userRepository.fetchProfile(
          id: prof.id,
        );
        Navigator.of(context).pushNamed('/userProfilePage', arguments: profile);
      },
      leading: CircleAvatar(
        radius: 45.0,
        // foregroundImage: NetworkImage(state
        //     .userList[index].profilePicture!.url
        //     .toString()),
        backgroundImage: NetworkImage(
          prof.profilePicture!.url,
        ),
        onBackgroundImageError: (exception, stackTrace) => const NetworkImage(
            'https://i.ibb.co/yPCqbSG/altruecompany-placeholder.png'),
      ),
      title: Text(prof.username!),
      trailing: list.contains(prof.id)
          ? MaterialButton(
              color: Colors.black,
              onPressed: () {
                ManageFollower follow =
                    ManageFollower(follow: 'unfollow', id: prof.id);
                context
                    .read<ProfileBloc>()
                    .add(RemoveFollower(interaction: follow));
              },
              child: const Text('Following',
                  style: TextStyle(color: Colors.white)),
            )
          : MaterialButton(
              onPressed: () {
                ManageFollower follow =
                    ManageFollower(follow: 'follow', id: prof.id);
                context
                    .read<ProfileBloc>()
                    .add(AddFollower(interaction: follow));
              },
              color: Colors.amber,
              child: const Text('Follow')),
    );
  }
}
