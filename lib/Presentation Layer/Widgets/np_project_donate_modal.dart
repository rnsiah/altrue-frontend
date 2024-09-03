import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Atrocity_Details/atroc_donate.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet_profile_card_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../Data Layer/Blocs/payment_type_bloc/payment_type_bloc_bloc.dart';
import '../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import '../../Data Layer/Models/donation_data_model.dart';
import '../../Data Layer/Models/nonprofit_project_model.dart';
import '../../Data Layer/Models/user_donation_model.dart';
import '../../Data Layer/Models/user_model.dart';

class NpProjectDonateModal extends StatefulWidget {
  final NonProfitProject project;
  final Profile profile;
  const NpProjectDonateModal(
      {super.key, required this.profile, required this.project});

  @override
  State<NpProjectDonateModal> createState() => _NpProjectDonateModalState();
}

class _NpProjectDonateModalState extends State<NpProjectDonateModal> {
  double amount = 0.0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: ListView(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.project.title,
                        softWrap: true,
                        maxLines: 2,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(widget.project.cause!.name!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          const Text('Cause',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'by:${widget.project.nonprofit!.name}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 8.0),
                  child: Text(
                    'Recent Donors',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                      height: widget.project.supporters!.isEmpty ? 20 : 80,
                      child: widget.project.supporters!.isEmpty
                          ? const Text(
                              'No Recent Donors',
                              style: TextStyle(color: Colors.white),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.project.supporters!.length,
                              itemBuilder: (context, index) => ProfileDot(
                                textColor: Colors.amber,
                                    dotRadius: 25,
                                    profile: widget.project.supporters![index],
                                  ))),
                ),
                const SizedBox(height: 3),
                ProfilePaymentCard(
                  heightFactor: .2,
                  profile: widget.profile,
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Choose Amount To Donate',
                    style: TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: widget.profile.balance! == 0
                      ? SizedBox(
                          child: Column(
                            children: [
                              const Text(
                                'Please raise funds to donate to this atrocity',
                                style: TextStyle(color: Colors.white),
                              ),
                              MaterialButton(
                                  color: Colors.black.withOpacity(.7),
                                  child: const Text(
                                    'Learn How',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {})
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .75,
                              child: Center(
                                child: Expanded(
                                  child: SfSlider(
                                      min: 0,
                                      stepSize: (widget.profile.balance! / 20)
                                                  .ceilToDouble() >
                                              0
                                          ? (widget.profile.balance! / 20)
                                              .ceilToDouble()
                                          : 0.1, // Ensure stepSize is at least 0.1
                                      interval: widget.profile.balance! / 5 > 0
                                          ? widget.profile.balance! / 5
                                          : 0.5, // Ensure interval is at least 0.5
                                      max: widget.profile.balance,
                                      value: amount,
                                      showTicks: true,
                                      activeColor: Colors.amber,
                                      showLabels: true,
                                      enableTooltip: true,
                                      thumbIcon: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(90)),
                                        child: const Icon(Icons.add),
                                      ),
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          amount = value;
                                        });
                                      }),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '\$${amount.ceilToDouble().toString()}',
                                style: const TextStyle(
                                    color: Colors.amber, fontSize: 19),
                              ),
                            )
                          ],
                        ),
                ),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .07,
                    width: MediaQuery.of(context).size.width * .8,
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state.status == ProfileStatus.paymentProcessing) {
                          Navigator.of(context).pop();
                          _handlePaymentProcessing(
                              context.read<ProfileBloc>(), state);
                          context
                              .read<ProfileBloc>()
                              .add(CheckDonationStatus());
                        }
                        return ElevatedButton(
                          onPressed: () {
                            final totalAmountInCents =
                                (amount.ceilToDouble() * 100).toInt();

                            context.read<ProfileBloc>().add(
                                MakeDonationWithUserFunds(
                                    donationData: DonationData(
                                        amount: totalAmountInCents,
                                        id: widget.project.id.toString(),
                                        donationType: "project")));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: const BorderSide(
                                          color: Colors.white)))),
                          child: const Text(
                            'Donate With Funds',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 22),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return MaterialButton(
                      onPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(MakeDonationWithAltrueFunds(
                              amount: amount.ceilToDouble(),
                              atrocity: null,
                              project: widget.project,
                              nonprofit: null,
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
              ])
        ]),
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
