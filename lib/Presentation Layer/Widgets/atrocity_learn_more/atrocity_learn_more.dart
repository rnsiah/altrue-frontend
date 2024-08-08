import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AtrocityLearnMore extends StatefulWidget {
  final Atrocity atrocity;
  const AtrocityLearnMore({
    Key? key,
    required this.atrocity,
  }) : super(key: key);

  @override
  State<AtrocityLearnMore> createState() => _AtrocityLearnMoreState();
}

class _AtrocityLearnMoreState extends State<AtrocityLearnMore> {
  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: (widget.atrocity.links != null)
          ? ListView.builder(
              itemCount: widget.atrocity.links!.length,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                        onTap: () =>
                            _launchURL(widget.atrocity.links![index].link),
                        subtitle: Text(
                          widget.atrocity.links![index].publication,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          widget.atrocity.links![index].title,
                          style: const TextStyle(fontSize: 20),
                        )),
                  ))
          : Text(
              '${widget.atrocity.title} has no relevent links at the moment',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.green),
            ),
    );
  }
}
