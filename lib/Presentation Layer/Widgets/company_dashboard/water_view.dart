import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/wave_view.dart';

class WaterView extends StatefulWidget {
  final Profile profile;
  const WaterView({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<WaterView> createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var nextLevel = widget.profile.altrueLevel!.maximumPoints + 1;
    var totalPoints = widget.profile.altruePoints!;
    var remainder = nextLevel - totalPoints;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 3.0),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4, bottom: 3),
                              child: widget.profile.altruePoints != null
                                  ? Text(
                                      '${widget.profile.altruePoints.toString()} / $nextLevel',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.amber,
                                      ),
                                    )
                                  : const Text('Do Something'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                'pts',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  letterSpacing: -0.2,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4, top: 2, bottom: 14),
                          child: widget.profile.altrueLevel == null
                              ? const Text('Do Something')
                              : Text(
                                  (widget.profile.altrueLevel!.name),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: Colors.amber,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 8, bottom: 16),
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.access_time,
                                  color: Colors.grey.withOpacity(0.5),
                                  size: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  'Last action',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: widget.profile.userActions!.isEmpty
                                    ? const Text(
                                        '0 pts',
                                        style: TextStyle(color: Colors.amber),
                                      )
                                    : Text(
                                        '${widget.profile.userActions!.last.altrueAction.pointsAwarded} pts',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color: Colors.amber,
                                        ),
                                      ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Text('image here')),
                                Flexible(
                                    child: widget
                                                .profile.userActions!.isEmpty ||
                                            widget.profile.userActions == null
                                        ? const Text(
                                            'Please Complete An Altrue Action.',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: Colors.amber,
                                            ),
                                          )
                                        : Text(
                                            widget.profile.userActions!.last
                                                .altrueAction.name!,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: Colors.amber,
                                            ),
                                          )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 34,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.indigo.withOpacity(0.4),
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.indigo.withOpacity(0.4),
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.remove,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8, top: 16),
                child: Container(
                  width: 60,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(80.0),
                        bottomLeft: Radius.circular(80.0),
                        bottomRight: Radius.circular(80.0),
                        topRight: Radius.circular(80.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: const Offset(2, 2),
                          blurRadius: 4),
                    ],
                  ),
                  child: WaveView(
                    percentageValue: ((remainder / nextLevel).toDouble() * 100),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
