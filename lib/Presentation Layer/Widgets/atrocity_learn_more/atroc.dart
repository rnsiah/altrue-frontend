import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AtroLearn extends StatelessWidget {
  final Atrocity atrocity;

  const AtroLearn({Key? key, required this.atrocity}) : super(key: key);

  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return (atrocity.links != null)
        ? SizedBox(
            child: ListView.builder(
                itemCount: atrocity.links!.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                          onTap: () => _launchURL(atrocity.links![index].link),
                          subtitle: Text(
                            atrocity.links![index].publication,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            atrocity.links![index].title,
                            style: const TextStyle(fontSize: 20),
                          )),
                    )),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${atrocity.title} has no relevent links at the moment',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          );
  }
}
