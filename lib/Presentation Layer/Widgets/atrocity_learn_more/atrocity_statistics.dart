import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';

import '../../../Data Layer/Models/quiz_question_model.dart';

class AtrocityStatistics extends StatefulWidget {
  final Atrocity atrocity;

  const AtrocityStatistics({Key? key, required this.atrocity})
      : super(key: key);

  @override
  State<AtrocityStatistics> createState() => _AtrocityStatisticsState();
}

class _AtrocityStatisticsState extends State<AtrocityStatistics> {
  @override
  Widget build(BuildContext context) {
    return widget.atrocity.links!.isNotEmpty? const SizedBox(
      height: double.infinity,
      child: Column(children: [
         const Padding(
           padding: EdgeInsets.all(8.0),
           child: Text('Take A Quiz', style: TextStyle(color: Colors.amber, fontSize: 19),),
         ),
        
           
        
      ],),
    )
          :const SizedBox();
  }
}


// Widget quizQuestionPage(QuizQuestion question){
//   bool gotAnswerCorrect = false;
//   bool pressed = false;
//   return Expanded(
//     child: Column(
//       children: [
//         Text(question.questionText, style: const TextStyle(color: Colors.amber, fontSize: 19, fontWeight: FontWeight.bold),),
//         ListView.builder(shrinkWrap: true,
//           itemCount: question.choices.length,
//           itemBuilder: (context, index)=>GestureDetector(
//             onTap: (){
//               print('pressed');
//               pressed = true;
//               if(question.choices[index].isCorrect==true){
//                 gotAnswerCorrect = true;
                
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: pressed==true?Colors.amber:Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: Colors.amber)
//                 ),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
                    
//                     question.choices[index].answer,softWrap: true,textAlign: TextAlign.center ,style: const TextStyle(color: Colors.black),),
//                 ))
//               ],),)
//             ),
//           ))
//       ],
//     ),
//   );
// }