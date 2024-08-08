import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';

class AltrueActionCard extends StatefulWidget {
  final AltrueAction? action;

  final int? levelNumber;
  const AltrueActionCard({super.key, this.action, this.levelNumber});

  @override
  State<AltrueActionCard> createState() => _AltrueActionCardState();
}

class _AltrueActionCardState extends State<AltrueActionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                backgroundColor: Colors.grey,
                insetPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 12,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 20,
                          width: 100,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'images/Altrue Logo White.png'))),
                        ),
                        Text(
                          widget.action!.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Reward: ${widget.action!.pointsAwarded!} points',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12.0, right:12),
                          child: Text(
                            widget.action!.info!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Text(
                          'Complete to unlock level ${widget.levelNumber} rewards and bonuses',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: SizedBox(
        width: 300,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.9),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 16, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 3, top: 2),
                            child: Text(
                              'Altrue Action',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  letterSpacing: -0.1,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.action!.name!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.amber,
                        ),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 24, right: 24, top: 8, bottom: 8),
                //   child: Container(
                //     height: 2,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14, right: 6, top: 0, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text(
                                'Reward',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '${widget.action!.pointsAwarded} points',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                'Required Level',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    widget.levelNumber.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: -0.2,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  // const Text(
                                  //   'Lvl',
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 8,
                                  //     color: Colors.amber,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
