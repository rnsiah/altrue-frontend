import 'package:flutter/material.dart';

import '../../Data Layer/Models/quiz_model.dart';
import '../../Data Layer/Models/user_model.dart';

class QuizResultsScreen extends StatefulWidget {
  final Profile profile;
  final int numOfCorrect;
  final Quiz quiz;
  final int numOfQuestions;
  final double finalScore;
  const QuizResultsScreen({super.key, required this.numOfCorrect, required this.numOfQuestions, required this.profile, required this.finalScore, required this.quiz});

  @override
  State<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends State<QuizResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Quiz Results'),
      backgroundColor: Colors.black,),
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/passquiz.jpeg'))),
        child: Center(
          child:  Container(
            height: MediaQuery.of(context).size.height*.5,
            width:  MediaQuery.of(context).size.width*.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(.9)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 100,width: 400,decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/Altrue Logo White.png'))),),
                Text('Your Score: ${widget.finalScore} % ',style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                widget.finalScore>70?Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Congratualations: You passed the quiz and are being rewarded for your heard work',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('As a result, you have been awarded  ${widget.quiz.action!.pointsAwarded} Altrue points to help you level up', textAlign: TextAlign.center, style: const TextStyle(color: Colors.amber),)
                    ],
                  ),
                ):const Text('Not This time.',style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                
              ],
            ),
          )),
      ),
    );
  }
}