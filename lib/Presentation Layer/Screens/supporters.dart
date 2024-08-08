import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class SupporterPage extends StatelessWidget {
  final Profile profile;

  const SupporterPage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Image(
              image: AssetImage('images/Altrue Logo White.png'),
            )),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(profile.username!),
                ),
                const SizedBox(
                  width: 9,
                ),
                Text('balance:${profile.balance}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ]),
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    'Recent Donations',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                )),
            SizedBox(
              height: 800,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: profile.donor!.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: const BorderSide(color: Colors.white)),
                          color: Colors.grey[900],
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.person,
                                  color: Colors.amber,
                                ),
                                title: Text(
                                  "${profile.donor![index].firstName} ${profile.donor![index].lastName}",
                                  style: const TextStyle(
                                      color: Colors.amber, fontSize: 20),
                                ),
                                subtitle: const Text(
                                  'Donated On: ',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      profile.donor![index].amountDonated,
                                      style: const TextStyle(
                                          color: Colors.amber, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Email email = Email(
                                            subject:
                                                'Hey ${profile.donor![index].firstName}, thanks for donating',
                                            body:
                                                'Hey${profile.donor![index].firstName}I want to thank you for donating to my efforts in helping the efforts towards ${profile.donor![index].altruCategory!.name} on the Altrue platform!',
                                            recipients: [
                                              profile.donor![index].email
                                            ],
                                            isHTML: false);
                                        FlutterEmailSender.send(email);
                                      },
                                      child: const Text(
                                        'Say Thanks',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  }),
            )
          ],
        ));
  }
}
