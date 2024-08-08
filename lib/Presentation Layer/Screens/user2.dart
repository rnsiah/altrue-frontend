// import 'package:flutter/material.dart';
// import 'package:mobile/Data_Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
// import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
// import 'package:mobile/Data_Layer/Models/user_model.dart';
// import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';
// import 'package:mobile/Presentation/Screens/atrocity_details.dart';
// import 'package:mobile/Presentation/Screens/atrocity_list.dart';

// class Home extends StatefulWidget {
//   final User user;

//    Home({Key? key, required this.user}) : super(key: key);
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//    PageController _pageController;
//    AtrocityBlocBloc atrocitybloc;

//   @override
//   void initState() {
//     atrocitybloc = AtrocityBlocBloc(atrocityRepository: context.read<AtrocityRepository>());
  
    
//     _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
//     // TODO: implement initState
//     super.initState();
//   }

//   _shirtSelector(int index){AnimatedBuilder(animation: _pageController, builder: (BuildContext context, Widget widget){
//       double value = 1;
//       if (_pageController.position.haveDimensions){
//         value = (_pageController.page! - index);
//         value = (1 - (value.abs() * 0.3) + 0.6).clamp(0.0, 1.0);
//       }
//       return Center(child: SizedBox(
//         height: Curves.easeInOut.transform(value) * 270.0,
//         width: Curves.easeInOut.transform(value) * 400,
//         child: widget,


//       ),
//       );
//   },
//       child: GestureDetector(
//         onTap: ()=> Navigator.push(
//             context, MaterialPageRoute(
//             builder: (_) => AtrocityDetails(atrocity: [index],)
//         )),
//         child: Stack(children: <Widget>[
//           Center(child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black54,
//                   offset: Offset(0.0, 4.0),
//                   blurRadius: 10.0,
//                 ),
//               ],
//             ),
//             child: Center(child: Hero(tag: '',
//               child: ClipRRect(borderRadius: BorderRadius.circular(10),
//                 child: Image(image: NetworkImage(''),
//                   height: 220.0,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             ),

//           ),),Positioned(
//             left: 30,
//             bottom: 40,
//             child: Text( '',style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w800
//             ),
//             ),
//           )

//         ],),
//       ),
//     );
//   }
//   },

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(),
//       ),
//     );
//   }
// }
// }