import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class ProfileMatchBottomSheet extends StatefulWidget {
  final Profile profile;
  const ProfileMatchBottomSheet({super.key, required this.profile});

  @override
  State<ProfileMatchBottomSheet> createState() =>
      _ProfileMatchBottomSheetState();
}

class _ProfileMatchBottomSheetState extends State<ProfileMatchBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      color: Colors.white,
      child: widget.profile.userdonations!.length > 1
          ? ListView.builder(
              itemCount: widget.profile.userdonations!.length,
              itemBuilder: (context, i) {
                if (widget.profile.userdonations![i].nonprofit != null) {
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  vertical: 100, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 12,
                              child: SizedBox(
                                height: 400,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: const [
                                    Text('Is Active'),
                                    Text('Match Percentage')
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                            widget.profile.userdonations![i].nonprofit!.name!),
                        subtitle:
                            Text(widget.profile.userdonations![i].dollarAmount),
                        trailing: MaterialButton(
                          child: const Text(
                            'NonProfit \n Match',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                } else if (widget.profile.userdonations![i].atrocity != null) {
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 12,
                              child: Container(
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: const [
                                    Text('Is Active'),
                                    Text('Match Percentage')
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                            widget.profile.userdonations![i].atrocity!.title),
                        subtitle:
                            Text(widget.profile.userdonations![i].dollarAmount),
                        trailing: MaterialButton(
                          child: const Text(
                            'Atrocity \n Match',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 12,
                            child: SizedBox(
                              height: 350,
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: const [
                                  Text('Is Active'),
                                  Text('Match Percentage')
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Card(
                    child: ListTile(
                      trailing: MaterialButton(
                        child: const Text('General \nMatch',
                            textAlign: TextAlign.center),
                        onPressed: () {},
                      ),
                      title: const Text('General Altrue Donation'),
                      subtitle:
                          Text(widget.profile.userdonations![i].dollarAmount),
                    ),
                  ),
                );
              })
          : const Center(
              child: Text(
                'No Recent Donations',
                style: TextStyle(color: Colors.black),
              ),
            ),
    );
  }
}
