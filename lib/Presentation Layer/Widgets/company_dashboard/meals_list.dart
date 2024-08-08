import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/donor_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class MealsListView extends StatefulWidget {
  const MealsListView({Key? key, this.profile, this.isProject, this.nonprofit})
      : super(key: key);

  final Profile? profile;
  final NonProfit? nonprofit;
  final bool? isProject;

  @override
  State<MealsListView> createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isProject == true && widget.nonprofit!.projects!.isNotEmpty ||
            widget.isProject == false && widget.profile!.donor!.isNotEmpty
        ? SizedBox(
            height: 216,
            width: double.infinity,
            child: widget.isProject == false
                ? ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: widget.profile!.donor!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return MealsView(
                        isDonor: true,
                        donor: widget.profile!.donor![index],
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: widget.nonprofit!.projects!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return MealsView(
                        isDonor: false,
                        project: widget.nonprofit!.projects![index],
                      );
                    },
                  ),
          )
        : SizedBox(
            height: 80,
            child: Center(
                child: widget.isProject == true
                    ? Text('${widget.nonprofit!.name} has no current projects')
                    : Text(
                        '${widget.profile!.username!}  has no recent donors',
                      )),
          );
  }
}

class MealsView extends StatelessWidget {
  const MealsView({Key? key, this.donor, this.isDonor, this.project})
      : super(key: key);
  final bool? isDonor;
  final Donor? donor;
  final NonProfitProject? project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
            child: isDonor == false
                ? Container(
                    width: 200,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.amber.withOpacity(0.6),
                            offset: const Offset(1.1, 2),
                            blurRadius: 2),
                      ],
                      // gradient: const LinearGradient(
                      //   colors: <Color>[
                      //     Colors.white,
                      //     Colors.black,
                      //   ],
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomRight,
                      // ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 54, left: 16, right: 16, bottom: 8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project!.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(children: const []),
                            ))
                          ]),
                    ))
                : Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.amber.withOpacity(0.6),
                            offset: const Offset(1.1, 2),
                            blurRadius: 2),
                      ],
                      // gradient: const LinearGradient(
                      //   colors: <Color>[
                      //     Colors.white,
                      //     Colors.black,
                      //   ],
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomRight,
                      // ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 54, left: 16, right: 16, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            donor != null ? donor!.firstName : '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    donor != null
                                        ? donor!.lastName
                                        : 'Amount Raised: ${project!.currentFunds}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isDonor == true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(donor!.altruCategory!.name!),
                                    Text(
                                      '\$${donor!.amountDonated}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(project!.fundraisingGoal.toString()),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              offset: const Offset(8.0, 8.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.indigo,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Container(
          //     width: 84,
          //     height: 84,
          //     decoration: BoxDecoration(
          //       color: Colors.white54.withOpacity(0.2),
          //       shape: BoxShape.rectangle,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 0,
          //   left: 8,
          //   child: SizedBox(
          //       width: 80,
          //       height: 80,
          //       child: userdonation!.nonprofit != null
          //           ? Image.network(userdonation!.nonprofit!.logo)
          //           : Container(
          //               height: 20,
          //             )),
          // )
        ],
      ),
    );
  }
}
