import 'package:flutter/material.dart';

import 'package:lovelovelove/Data%20Layer/Models/quiz_question_model.dart';

class QuestionsNumberWidget extends StatelessWidget {
  final List<QuizQuestion> questions;
  final QuizQuestion question;
  final ValueChanged<int> onClickedNumber;
  const QuestionsNumberWidget({super.key, required this.onClickedNumber, required this.question, required this.questions, });

  @override
  Widget build(BuildContext context) {
    const  double padding = 16; 
    return SizedBox(
      height: 50,
      child: 
      ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: padding),
        physics: const BouncingScrollPhysics(),
        itemCount: questions.length,
        separatorBuilder: (context,index)=>Container(width: padding,),
        itemBuilder: (context, index){
          final isSelected =question == questions[index];
          return buildNumber(index:index, isSelected:isSelected);
        } ,
      ),
      
    );
  }
  Widget buildNumber({required index, required isSelected}){
    final Color color = isSelected? Colors.amber :Colors.black;
    return GestureDetector(
      onTap: ()=>onClickedNumber(index),
      child: CircleAvatar(
        backgroundColor: color,
        child: Text('${index+1}', style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}