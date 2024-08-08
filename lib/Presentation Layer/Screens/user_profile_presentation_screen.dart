import 'package:flutter/material.dart';

import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/user_model.dart';

class ProfilePresentationScreen extends StatefulWidget {
  final Profile profile;
  const ProfilePresentationScreen({super.key, required this.profile});

  @override
  State<ProfilePresentationScreen> createState() =>
      _ProfilePresentationScreenState();
}

class _ProfilePresentationScreenState extends State<ProfilePresentationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Image(image: AssetImage('images/Altrue Logo White.png')),
      ),
      body: Container(
        color: Colors.grey[900],
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .4 - 50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(widget.profile.profilePicture!.url),
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.amber),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topLeft: Radius.circular(50)),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 50,
                                  color: Colors.black)
                            ],
                            color: Colors.white),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Material(
                                      elevation: 5,
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: widget
                                                                .profile
                                                                .altrueLevel!
                                                                .levelNumber <
                                                            1 &&
                                                        widget
                                                                .profile
                                                                .altrueLevel!
                                                                .levelNumber >
                                                            4
                                                    ? const AssetImage(
                                                        'images/level 3.png')
                                                    : AssetImage(
                                                        'images/level ${widget.profile.altrueLevel!.levelNumber}.png'))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text('Level'),
                                  ],
                                ),
                              ),
                              Column(
                                children: const [],
                              ),
                              MaterialButton(
                                color: Colors.amber,
                                onPressed: () {},
                                child: const Text('Add'),
                              )
                            ]),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile.username!,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Altrue Level:${widget.profile.altrueLevel!.name}',
                      style: const TextStyle(color: Colors.amber, fontSize: 16),
                    )
                  ],
                )),
                SizedBox(
                  height: 64,
                  width: 64,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      onPressed: () {},
                      child: const Icon(
                        Icons.add,
                        color: Colors.amber,
                      )),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: SizedBox(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.profile.nonProfitList!.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2)),
                                child: Image.network(
                                  widget.profile.nonProfitList![index].logo,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Me',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.profile.description!,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget npBox(NonProfit np) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: NetworkImage(np.logo))),
    ),
  );
}
