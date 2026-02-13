import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/np_atributes.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Data Layer/Blocs/payment_type_bloc/payment_type_bloc_bloc.dart';
import '../../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import '../../../Data Layer/Models/donation_data_model.dart';
import '../../../Data Layer/Models/user_donation_model.dart';
import '../NonProfit_Details/nonprofit_learn_more/nonprofit_learn_more_tabs.dart';
import '../payment_sheet_profile_card_widget.dart';

class AtrocityDonateModal extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityDonateModal(
      {Key? key, required this.atrocity, required this.profile})
      : super(key: key);

  @override
  _AtrocityDonateModalState createState() => _AtrocityDonateModalState();
}

class _AtrocityDonateModalState extends State<AtrocityDonateModal> {
  double _amount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double finalAmount = double.parse((_amount).toStringAsFixed(2));

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.paymentAccepted) {
          context.go('/rewardhome/thankyou',
              extra: ThankYouScreenArguments(
                  isAtrocity: true,
                  isNonProfit: false,
                  isProject: false,
                  isPurchase: false));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28)),
                color: Colors.white.withOpacity(.7)),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AtrocityInfo(atrocity: widget.atrocity),
                    
                   
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfilePaymentCard(
                                profile: widget.profile,
                                heightFactor: .2,
                              ),
                              // DriverInfo(),

                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        )
                      ],
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: widget.profile.balance == null ||
                                            widget.profile.balance! <= 0
                                        ? const Text('Please refill your account')
                                        : SfSlider(
                                            inactiveColor: Colors.white,
                                            min: 0,
                                            max: widget.profile.balance,
                                            value: _amount,
                                            stepSize: (widget.profile.balance! /
                                                            20)
                                                        .ceilToDouble() >
                                                    0
                                                ? (widget.profile.balance! / 20)
                                                    .ceilToDouble()
                                                : 0.1, // Ensure stepSize is at least 0.1
                                            interval: widget.profile.balance! /
                                                        5 >
                                                    0
                                                ? widget.profile.balance! / 5
                                                : 0.5, // Ensure interval is at least 0.5
                                            showTicks: true,
                                            activeColor: Colors.amber,
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
                                        style: const TextStyle(fontSize: 20),
                                      )))
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      if (state.status == ProfileStatus.paymentProcessing) {
                        Navigator.of(context).pop();
                        _handlePaymentProcessing(
                            context.read<ProfileBloc>(), state);
                      }
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                          child: Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              color: Colors.amber,
                              onPressed: () {
                                final totalAmountInCents =
                                    (_amount.roundToDouble() * 100).toInt();

                                context
                                    .read<ProfileBloc>()
                                    .add(MakeDonationWithUserFunds(
                                        donationData: DonationData(
                                      id: widget.atrocity.id.toString(),
                                      amount: totalAmountInCents,
                                      donationType: 'atrocity',
                                    )));
                              },
                              child: const Text('Donate With Funds'),
                            ),
                          ));
                    }),
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      if (state.status == ProfileStatus.updating) {
                        return const CircularProgressIndicator(
                          color: Colors.black,
                        );
                      }
                      return Column(
                        children: [
                          SizedBox(height: 20,),
                          SizedBox(
                            width: double.infinity,
                              height: MediaQuery.of(context).size.height * .06,
                              child: Expanded(
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28)),
                                  color: Colors.amber,
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(
                                        MakeDonationWithAltrueFunds(
                                            nonprofit: null,
                                            atrocity: widget.atrocity,
                                            project: null,
                                            amount: _amount));
                                  },
                                  child: Text('Donate With Altrue Wallet'),
                                ),
                              )),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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
}

class AtrocityInfo extends StatelessWidget {
  const AtrocityInfo({
    Key? key,
    required this.atrocity,
  }) : super(key: key);

  final Atrocity atrocity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    atrocity.title,
                    style: const TextStyle(
                      shadows: [
                        Shadow(
                            offset: Offset(.5, 0.5),
                            blurRadius: 1.0,
                            color: Colors.black),
                      ],
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Attribute(
                    value: atrocity.category![0].name!,
                    name: 'Causes',
                    textColor: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recent Donors',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          SizedBox(
                            height: atrocity.recentDonors == null ||
                                    atrocity.recentDonors!.isEmpty
                                ? 20
                                : 80,
                            child: atrocity.recentDonors == null ||
                                    atrocity.recentDonors!.isEmpty
                                ? const Text('No Recent Donors')
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        5,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ProfileDot(
                                          textColor: Colors.red,
                                            profile: 
                                                atrocity.recentDonors![index],
                                            dotRadius: 10),
                                      );
                                    }),
                          )
                        ],
                      ),
            Attribute(
              value: atrocity.balance.toString(),
              name: 'Donations This Wekk',
              textColor: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}

class ProfileDot extends StatelessWidget {
  final ProfileRepresentation profile;
  final double? dotRadius;
  final Color? textColor;
  const ProfileDot({Key? key, required this.profile, this.dotRadius = 25, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          CircleAvatar(
              radius: dotRadius,
              foregroundImage: NetworkImage(profile.profilePicture!.url),
              backgroundColor: Colors.white),
          Text(profile.username!, style: TextStyle(color:textColor, fontSize: 8),)
        ],
      ),
    );
  }
}
