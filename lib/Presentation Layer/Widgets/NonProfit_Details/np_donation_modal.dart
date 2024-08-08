// import 'package:flutter/material.dart';
// import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

// import '../np_atributes.dart';

// class NpDonationModal extends StatelessWidget {
//   final NonProfit nonProfit;
//   const NpDonationModal({Key? key, required this.nonProfit}) : super(key: key);

//   List<Widget> getRecentDonors(NonProfit nonProfit) {
//     return nonProfit.recentDonors!.map((e) {
//       return ProfileDot(profile: e);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 700,
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(16)),
//       child: Column(
//         children: [
//           Row(
//             children: getRecentDonors(nonProfit),
//           ),
//           NonProfitInfo(nonProfit: nonProfit),
//           const Divider(
//             height: 2,
//             color: Colors.black54,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(
//                 nonProfit.logo,
//                 height: 120,
//               ),
             
//               Expanded(
//                 child: Column(
//                   children: const [
//                     // DriverInfo(),
//                     //

//                     // DiverAppraise(),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     DonationButton(),
//                   ],
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }


