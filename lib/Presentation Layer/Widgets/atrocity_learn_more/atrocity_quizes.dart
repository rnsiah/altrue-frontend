import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

class AtrocityQuizes extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityQuizes({super.key, required this.atrocity, required this.profile});

  @override
  State<AtrocityQuizes> createState() => _AtrocityQuizesState();
}

class _AtrocityQuizesState extends State<AtrocityQuizes> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: widget.atrocity.quizes!.length,
      itemBuilder: (context, index)=> Card(
        child: ListTile(title: 
        Text(widget.atrocity.quizes![index].title),
        onTap: ()=>{
          Navigator.of(context).pushNamed('/quizpage',
          arguments: QuizPageArguments(
          quiz: widget.atrocity.quizes![index],
           profile: widget.profile))
        },
      ),
   ));
  }
}