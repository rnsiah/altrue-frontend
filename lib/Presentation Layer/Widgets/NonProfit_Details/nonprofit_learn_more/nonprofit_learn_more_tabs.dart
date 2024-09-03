import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import 'package:selection_menu/selection_menu.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import '../../../../Data Layer/Models/donation_data_model.dart';
import '../../../../Data Layer/Models/user_donation_model.dart';
import '../../../Routers/functionality_router.dart';
import '../../np_atributes.dart';
import '../../payment_sheet_profile_card_widget.dart';

class NpDonate extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NpDonate({Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  State<NpDonate> createState() => _NpDonateState();
}

class _NpDonateState extends State<NpDonate> {
  double _amount = 0;

  List<String> projects(NonProfit nonProfit) {
    List<String> titles = ['None'];
    for (var project in nonProfit.projects!) {
      titles.add(project.title);
    }

    return titles;
  }

  List<String> projectTitles(NonProfit nonProfit) {
    List<String> titles = [];
    for (var project in nonProfit.projects!) {
      titles.add(project.title);
    }
    return titles;
  }

  List<Widget> getRecentDonors(NonProfit nonProfit) {
    List<ProfileRepresentation> list = nonProfit.recentDonors!.toSet().toList();
    if (list.length < 5) {
      return list.map((e) {
        return ProfileDot(profile: e);
      }).toList();
    }
    return list.take(4).toList().map((e) {
      return ProfileDot(profile: e);
    }).toList();
  }

  String _selectedItem = 'None';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double finalAmount = double.parse((_amount).toStringAsFixed(2));
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.paymentAccepted) {
          Navigator.of(context).popAndPushNamed('/thankyou',
              arguments: ThankYouScreenArguments(
                  isNonProfit: true,
                  isAtrocity: false,
                  isProject: false,
                  isPurchase: false));
        }
      },
      child: Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28))),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: ListView(
              shrinkWrap: false,
              children: [
                NonProfitInfo(nonProfit: widget.nonProfit),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Donors',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                        height: 59,
                        child: widget.nonProfit.recentDonors == null ||
                                widget.nonProfit.recentDonors!.isEmpty
                            ? const Text('No Recent Donors')
                            : ListView(
                                padding: const EdgeInsets.symmetric(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: getRecentDonors(widget.nonProfit),
                              ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.nonProfit.logo,
                      height: 60,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DriverInfo(),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            'Donate To Specific Project',
                            style: TextStyle(fontSize: 16),
                          ),

                          widget.nonProfit.projects != null
                              ? DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(16),
                                  value: _selectedItem,
                                  focusColor: Colors.black,
                                  items: projects(widget.nonProfit).map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedItem = value!;
                                    });
                                  },
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfilePaymentCard(
                  profile: widget.profile,
                  heightFactor: .2,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: widget.profile.balance == null ||
                                      widget.profile.balance! <= 0
                                  ? const Text('Please refill your account')
                                  : SfSlider(
                                      min: 0,
                                      max: widget.profile.balance,
                                      value: _amount,
                                      stepSize: (widget.profile.balance! / 20)
                                                  .ceilToDouble() >
                                              0
                                          ? (widget.profile.balance! / 20)
                                              .ceilToDouble()
                                          : 0.1, // Ensure stepSize is at least 0.1
                                      interval: widget.profile.balance! / 5 > 0
                                          ? widget.profile.balance! / 5
                                          : 0.5, // Ensure interval is at least 0.5
                                      showTicks: false,
                                      activeColor: Colors.black,
                                      showLabels: true,
                                      enableTooltip: true,
                                      thumbIcon: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Icon(Icons.add),
                                      ),
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _amount = value;
                                        });
                                      }),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: () {
                                    // Open a keyboard to allow user input
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: Text(
                                    '\$${_amount.roundToDouble().toString()}',
                                    style: TextStyle(fontSize: 20),
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),
                Center(child: Text('Choose Amount')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state.status == ProfileStatus.paymentProcessing) {
                      Navigator.of(context).pop();

                      _handlePaymentProcessing(
                          context.read<ProfileBloc>(), state);
                    }
                    return MaterialButton(
                      onPressed: () {
                        final totalAmountInCents =
                            (_amount.roundToDouble() * 100).toInt();
                        context.read<ProfileBloc>().add(
                            MakeDonationWithUserFunds(
                                donationData: DonationData(
                                    amount: totalAmountInCents,
                                    id: widget.nonProfit.slug!,
                                    donationType: 'nonprofit')));
                      },
                      height: MediaQuery.of(context).size.height * .06,
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Text(
                        'Donate Funds',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return MaterialButton(
                      onPressed: () {
                        final totalAmountInCents = (_amount);
                        context
                            .read<ProfileBloc>()
                            .add(MakeDonationWithAltrueFunds(
                              amount: _amount,
                              atrocity: null,
                              project: null,
                              nonprofit: widget.nonProfit,
                            ));
                      },
                      height: MediaQuery.of(context).size.height * .06,
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Text(
                        'Donate From Altrue Wallet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
    // child: Column(
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(30),
    //         color: Colors.white,
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Container(
    //             child: Column(
    //               children: [
    //                 Text(
    //                   widget.profile.username!,
    //                   style: TextStyle(color: Colors.amber, fontSize: 22),
    //                 ),
    //                 SizedBox(
    //                   height: 6,
    //                 ),
    //                 Text(
    //                   'Altrue Balance',
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //                 Text(
    //                   widget.profile.balance.toString(),
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             color: Colors.black,
    //             child: Column(
    //               children: [
    //                 Text(
    //                   widget.nonProfit.name,
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       width: 180,
    //       child: TextFormField(
    //           initialValue: _amount.toString(),
    //           decoration: InputDecoration(
    //             labelText: 'Amount to Donate',
    //           )),
    //     ),
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: SfSlider(
    //       min: 0,
    //       max: widget.profile.balance,
    //       value: _amount,
    //       interval: 1,
    //       showTicks: true,
    //       showLabels: true,
    //       enableTooltip: true,
    //       thumbIcon: Container(
    //         child: Icon(Icons.add),
    //         decoration:
    //             BoxDecoration(borderRadius: BorderRadius.circular(90)),
    //       ),
    //       onChanged: (dynamic value) {
    //         setState(() {
    //           _amount = value;
    //         });
    //       }),
    // ),

    // Text('Donate To Specific Project'),
    // SizedBox(
    //   height: 12,
    // ),
    // DropdownButton<String>(
    //   value: _selectedItem,
    //   items: projects(widget.nonProfit).map((e) {
    //     return DropdownMenuItem<String>(
    //       child: Text(e),
    //       value: e,
    //     );
    //   }).toList(),
    //   onChanged: (value) {
    //     setState(() {
    //       _selectedItem = value!;
    //     });
    //   },
    // ),

    // AwesomeDropDown(
    //     selectedItem: _selectedItem,
    //     onDropDownItemClick: (selectedItem) {
    //       setState(() {
    //         _selectedItem = selectedItem;
    //       });
    //     },
    //     numOfListItemToShow: 7,
    //     dropDownList: title(widget.nonProfit)),

    // SmartSelect.single(
    //   selectedValue: value,
    //   choiceItems: love,
    // ),

    //     SizedBox(
    //       height: 120,
    //     ),
    //     Text("\$" + finalAmount.toString())

    //     // SelectionMenu<ListTile>(
    //     //     itemBuilder:this.itemBuilder(context, , () { }),
    //     //     itemsList: list,
    //     //     onItemSelected: onItemSelected)
    //   ],
    // ),
  }

  Future<void> showSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentProcessing(
      ProfileBloc profileBloc, ProfileState state) async {
    try {
      await showSheet();
      await Future.delayed(const Duration(seconds: 5));
      profileBloc.add(CheckDonationStatus());
    } catch (e) {
      print(e);
    }
  }

  Widget itemBuilder(BuildContext context, NonProfitProject project,
      OnItemTapped onItemTapped) {
    return ListTile(
      title: Text(
        project.title,
      ),
      onTap: onItemTapped,
    );
  }
}

class DonationButton extends StatelessWidget {
  const DonationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      height: 70,
      color: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Text(
        'Donate Now',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class NonProfitInfo extends StatelessWidget {
  const NonProfitInfo({
    Key? key,
    required this.nonProfit,
  }) : super(key: key);

  final NonProfit nonProfit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nonProfit.name,
          style: const TextStyle(
            shadows: [
              Shadow(
                  offset: Offset(.5, 0.5),
                  blurRadius: 1.0,
                  color: Colors.black),
            ],
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Attribute(
              value: 'Altrue',
              name: 'Causes',
              textColor: Colors.black87,
            ),
            Attribute(
              value: '\$ ${nonProfit.balance}',
              name: 'Donations This Wekk',
              textColor: Colors.black87,
            ),
          ],
        )
      ],
    );
  }
}

class ProfileDot extends StatelessWidget {
  final ProfileRepresentation profile;
  const ProfileDot({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          foregroundImage: NetworkImage(profile.profilePicture!.url),
          backgroundColor: Colors.black,
        ),
        Text(
          profile.username!,
          style: const TextStyle(fontSize: 9),
        )
      ],
    );
  }
}
