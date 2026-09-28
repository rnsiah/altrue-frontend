import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/manage_followers_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Find Friends',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: GlassmorphismTheme.glassGradientStrong,
        ),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                  child: GlassCard(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person_add,
                              color: Colors.amber.shade400),
                          title: Text('Invite Friends',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.amber.shade400, size: 16),
                          onTap: () {
                            print('');
                          },
                        ),
                        Divider(
                            color: Colors.white.withOpacity(0.2), height: 1),
                        ListTile(
                          leading: Icon(Icons.contacts,
                              color: Colors.amber.shade400),
                          title: Text('Contacts',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.amber.shade400, size: 16),
                        ),
                        Divider(
                            color: Colors.white.withOpacity(0.2), height: 1),
                        ListTile(
                          leading: Icon(Icons.facebook,
                              color: Colors.amber.shade400),
                          title: Text('Facebook Friends',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.amber.shade400, size: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: GlassmorphismTheme.lg),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                  child: Text('Suggested Friends',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.amber.shade400,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: GlassmorphismTheme.md),
                BlocBuilder<AllUsersBloc, AllUsersState>(
                  builder: (context, state) {
                    if (state.status == ProfileListStatus.successful) {
                      return ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: state.userList.length,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: GlassmorphismTheme.md,
                                    vertical: GlassmorphismTheme.xs),
                                child: FriendTile(
                                    pro: widget.profile,
                                    userRepository: userRepository,
                                    prof: state.userList[index]),
                              ));
                    } else if (state.status == ProfileListStatus.failure) {
                      return Padding(
                        padding: EdgeInsets.all(GlassmorphismTheme.md),
                        child: GlassCard(
                          child: Center(
                            child: Text(
                                'Something Went Wrong. Please check your connection',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8))),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.all(GlassmorphismTheme.sm),
                      child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.amber.shade400),
                      ),
                    );
                  },
                )
              ],
            ),
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
    return GlassCard(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: GlassmorphismTheme.md, vertical: GlassmorphismTheme.xs),
        onTap: () async {
          Profile profile = await userRepository.fetchProfile(
            id: prof.id,
          );
          context.go('/newPosts/userProfilePage', extra: profile);
        },
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber.shade400, width: 2),
          ),
          child: CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage(
              prof.profilePicture!.url,
            ),
            onBackgroundImageError: (exception, stackTrace) =>
                const NetworkImage(
                    'https://i.ibb.co/yPCqbSG/altruecompany-placeholder.png'),
          ),
        ),
        title: Text(
          prof.username!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: list.contains(prof.id)
            ? GlassButton(
                onPressed: () {
                  ManageFollower follow =
                      ManageFollower(follow: 'unfollow', id: prof.id);
                  context
                      .read<ProfileBloc>()
                      .add(RemoveFollower(interaction: follow));
                },
                text: 'Following',
                backgroundColor: Colors.black.withOpacity(0.3),
                textColor: Colors.white,
                // borderColor: Colors.amber.shade400,
              )
            : GlassButton(
                onPressed: () {
                  ManageFollower follow =
                      ManageFollower(follow: 'follow', id: prof.id);
                  context
                      .read<ProfileBloc>()
                      .add(AddFollower(interaction: follow));
                },
                text: 'Follow',
                backgroundColor: Colors.amber.shade400.withOpacity(0.2),
                textColor: Colors.amber.shade400,
                // borderColor: Colors.amber.shade400,
              ),
      ),
    );
  }
}
