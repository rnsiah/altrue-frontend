import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/posts_bloc/bloc/posts_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_event_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/new_posts_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

import '../../Data Layer/Models/post_model.dart';

class ProfileDrawer extends StatefulWidget {
  final Profile profile;

  final NonProfitRespository nonProfitRespository = NonProfitRespository();
  final CompanyRepository companyRepository = CompanyRepository();
  final PostRepository postRepository = PostRepository();

  ProfileDrawer({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

final ImagePicker _picker = ImagePicker();

Future<dynamic> _getImage() async {
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  } catch (e) {
    Exception(e.toString());
  }
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: Drawer(
            child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              await _getImage().then((value) => context
                                  .read<ProfileBloc>()
                                  .add(ChangeProfilePicture(
                                      profilePicture: value)));
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: CircleAvatar(
                            radius: 45.0,
                            // foregroundImage:
                            //     NetworkImage(widget.profile.profilePicture!.url),
                            backgroundImage: NetworkImage(
                                widget.profile.profilePicture!.url),
                          ),
                        ),
                        Column(children: [
                          Align(
                            child: Text(
                              widget.profile.username!,
                              style: const TextStyle(color: Colors.amber),
                            ),
                          ),
                          const Text("Altrue Balance:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              )),
                          Text(widget.profile.balance.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              )),
                        ])
                      ]),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Altrue Level: ${widget.profile.altrueLevel!.levelNumber}',
                      style: const TextStyle(color: Colors.amber),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.black87,
                child: ListTile(
                  leading:
                      const Icon(Icons.person, color: Colors.amberAccent),
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed('/userProfile', arguments: widget.profile),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: BlocProvider<PostsBloc>(
                create: (context) => PostsBloc(),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.black87,
                  child: ListTile(
                    leading:
                        const Icon(Icons.person, color: Colors.amberAccent),
                    title: const Text(
                      'Altrue Updates',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    onTap: () async{
                      List<Post> posts = await widget.postRepository.fetchNewPosts();
                      Navigator.of(context)
                        .pushNamed('/newPosts', arguments: NewPostsScreenArguments(postList: posts, profile: widget.profile));
                    },
                  ),
                ),
              ),
            ),
            Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                        '/usernonprofits',
                        arguments: widget.profile),
                    leading: const Icon(Icons.favorite, color: Colors.white),
                    title: const Text(
                      'My Non Profits',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ))),
            Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed('/supporters', arguments: widget.profile),
                  leading: const Icon(Icons.people, color: Colors.amber),
                  title: const Text(
                    'My Supporters',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                )),
            Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                    leading: const Icon(Icons.camera, color: Colors.white),
                    title: const Text(
                      'My Altrue Code',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/myQrCode', arguments: widget.profile);
                    })),
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: const Icon(Icons.store, color: Colors.white),
                title: widget.profile.hasCompany!
                    ? const Text('My Company Details',
                        style: TextStyle(color: Colors.white, fontSize: 18))
                    : const Text('Register A Company',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: widget.profile.hasCompany!
                    ? () async {
                        ForProfitCompany company = await widget
                            .companyRepository
                            .fetchCompanyById(widget.profile.comp!.id);
                        Navigator.of(context).pushNamed('/CompanyHome',
                            arguments: CompanyHomeArguments(
                                company: company, profile: widget.profile));
                      }
                    : () {
                        Navigator.of(context).pushNamed('/companyRegister',
                            arguments: widget.profile);
                      },
              ),
            ),
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: const Icon(Icons.store, color: Colors.amber),
                title: widget.profile.hasNonProfit!
                    ? const Text('My NonProfit Details',
                        style: TextStyle(color: Colors.white, fontSize: 18))
                    : const Text('Register A NonProfit',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () async {
                  if (widget.profile.hasNonProfit == true) {
                    NonProfit nonprofit = await widget.nonProfitRespository
                        .fetchNonProfit(widget.profile.np!.id);
                    Navigator.of(context).pushNamed('/mynonprofit',
                        arguments: MyNonProfitDetailArgments(
                            nonprofit: nonprofit, profile: widget.profile));
                  } else if (widget.profile.hasNonProfit != true) {
                    Navigator.of(context).pushNamed('/nonprofitRegister',
                        arguments: widget.profile);
                  }
                },
              ),
            ),
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: const Icon(Icons.close, color: Colors.amber),
                title: const Text(
                  'Sign Out Now',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                onTap: () {
                  context.read<SessionBLoc>().add(LoggedOut());
                },
              ),
            ),
          ]),
        )));
  }
}
