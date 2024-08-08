import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../Data Layer/Models/user_model.dart';

class EnterPointsWidget extends StatefulWidget {
  final int availablePoints;
  final List<OrderItem>? shirts;

  EnterPointsWidget({
    this.shirts,
    required this.availablePoints,
  });

  @override
  _EnterPointsWidgetState createState() => _EnterPointsWidgetState();
}

class _EnterPointsWidgetState extends State<EnterPointsWidget> {
  late TextEditingController _pointsController;

  @override
  void initState() {
    super.initState();
    _pointsController = TextEditingController();
  }

  @override
  void dispose() {
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.hybridPayment) {
          return HybridPointPayment(
              profile: context.read<ProfileBloc>().state.profile!,
              availablePoints: state.profile!.altruePoints!,
              onSubmitPoints: ((p0) {
                context.read<ProfileBloc>().add(HybridPaymentPoints(
                    pointAmount: p0, shirts: widget.shirts));
              }),
              pointsController: _pointsController);
        } else if (state.status == ProfileStatus.hybridPaymentFunds) {
          return HybridFundPayment(
              amountleftToPay:
                  state.paymentIntentData!['amount_remaining'].toString());
        }
        return Container();
      },
    );
  }
}

class HybridFundPayment extends StatelessWidget {
  const HybridFundPayment({
    super.key,
    required this.amountleftToPay,
  });

  final String amountleftToPay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(28)),
        height: MediaQuery.of(context).size.height *
            0.2, // 1/5 of the screen height
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              Text(
                'New Balance',
                style: TextStyle(color: Colors.amber),
              ),
              Text(
                amountleftToPay,
                style: TextStyle(color: Colors.amber),
              )
            ],
          ),
          MaterialButton(
            color: Colors.white,
            onPressed: () async {
              ProfileBloc profileBloc = context.read<ProfileBloc>();
              await Stripe.instance.presentPaymentSheet();
              await Future.delayed(Duration(seconds: 8));
              profileBloc.add(ConfirmOrder());
            },
          )
        ]),
      ),
    );
  }
}

class HybridPointPayment extends StatefulWidget {
  const HybridPointPayment({
    super.key,
    required this.availablePoints,
    required this.profile,
    required this.onSubmitPoints,
    required TextEditingController pointsController,
  }) : _pointsController = pointsController;

  final int availablePoints;
  final Function(int) onSubmitPoints;
  final TextEditingController _pointsController;
  final Profile profile;

  @override
  State<HybridPointPayment> createState() => _HybridPointPaymentState();
}

class _HybridPointPaymentState extends State<HybridPointPayment> {
  @override
  Widget build(BuildContext context) {
    double _amount = 0;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(28)),

          height: MediaQuery.of(context).size.height *
              0.2, // 1/5 of the screen height
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Points: ${widget.availablePoints}',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      int points =
                          int.tryParse(widget._pointsController.text) ?? 0;
                      widget.onSubmitPoints(points);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
              SizedBox(
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                      activeTrackHeight: 8,
                      inactiveTrackHeight: 8,
                      tooltipBackgroundColor: Colors.amber,
                      inactiveTickColor: Colors.amber,
                      inactiveMinorTickColor: Colors.red,
                      activeTickColor: Colors.amber),
                  child: Center(
                    child: Expanded(
                      child: SfSlider(
                          min: 0,
                          max: widget.profile.balance,
                          value: _amount,
                          interval: 20,
                          showTicks: true,
                          activeColor: Colors.amber,
                          showLabels: true,
                          enableTooltip: true,
                          thumbIcon: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90)),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Points',
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28)),
                      child: FractionallySizedBox(
                        widthFactor: .25,
                        child: TextField(
                          controller: widget._pointsController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                              // labelText: 'Enter Points ',
                              // labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                              border: InputBorder.none,
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.amber),
                              // ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              fillColor: Colors.white,
                              filled: true),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
