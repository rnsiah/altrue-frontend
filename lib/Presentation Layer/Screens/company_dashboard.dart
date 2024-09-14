import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/meals_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/water_view.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key, required this.profile}) : super(key: key);

  final Profile profile;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    addAllListData();
    // animationController = AnimationController(vsync: this);
    // topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //     CurvedAnimation(
    //         parent: animationController!,
    //         curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    // scrollController.addListener(() {
    //   if (scrollController.offset >= 24) {
    //     if (topBarOpacity != 1.0) {
    //       setState(() {
    //         topBarOpacity = 1.0;
    //       });    //     }
    //   } else if (scrollController.offset <= 24 &&
    //       scrollController.offset >= 0) {
    //     if (topBarOpacity != scrollController.offset / 24) {
    //       setState(() {
    //         topBarOpacity = scrollController.offset / 24;
    //       });
    //     }
    //   } else if (scrollController.offset <= 0) {
    //     if (topBarOpacity != 0.0) {
    //       setState(() {
    //         topBarOpacity = 0.0;
    //       });
    //     }
    //   }
    // });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    // List<MediterranesnDietView> views = [
    //   MediterranesnDietView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: animationController!,
    //         curve:
    //             Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: animationController!,
    //   ),
    //   MediterranesnDietView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: animationController!,
    //         curve:
    //             Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: animationController!,
    //   ),
    //   MediterranesnDietView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: animationController!,
    //         curve:
    //             Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: animationController!,
    //   ),
    //   MediterranesnDietView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: animationController!,
    //         curve:
    //             Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: animationController!,
    //   ),
    // ];

    listViews.add(
      TitleView(
        color: Colors.amber,
        ontap: () {
          Navigator.of(context)
              .pushNamed('/userProfile/creditCardDetails', arguments: widget.profile);
        },
        titleTxt: 'My Altrue Stats',
        subTxt: 'Payment Details',
      ),
    );
    listViews.add(
      MediterranesnDietView(
        isProfileInfo: true,
        isCompanyInfo: false,
        profile: widget.profile,
        color: Colors.grey[800],
        textColor: Colors.amber,
      ),
    );
    listViews.add(
      TitleView(
        ontap: () {
          context.go('/userProfile/supporters', extra: widget.profile);
        },
        titleTxt: 'Recent Donations',
        subTxt: 'See All',
        color: Colors.amber,
      ),
    );

    listViews.add(
      MealsListView(
        profile: widget.profile,
        isProject: false,
      ),
    );

    listViews.add(TitleView(
      titleTxt: 'Altrue Engagement',
      subTxt: 'See More',
      color: Colors.amber,
      ontap: () => Navigator.of(context)
          .pushNamed('/altrueActionsScreen', arguments: widget.profile),
    ));

    // listViews.add(
    //   ActionCardList(profile: widget.profile),
    // );
    // listViews.add(
    //   const TitleView(
    //     titleTxt: 'Water',
    //     subTxt: 'Aqua SmartBottle',
    //   ),
    // );

    listViews.add(
      WaterView(
        profile: widget.profile,
      ),
    );
    // listViews.add(
    //   GlassView(
    //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //           CurvedAnimation(
    //               parent: animationController!,
    //               curve: Interval((1 / count) * 8, 1.0,
    //                   curve: Curves.fastOutSlowIn))),
    //       animationController: animationController!),
    // );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[900],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(topBarOpacity),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * topBarOpacity,
                    bottom: 12 - 8.0 * topBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.profile.username!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * topBarOpacity,
                            letterSpacing: 1.2,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {},
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                          Text(
                            '15 May',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              letterSpacing: -0.2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {},
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
