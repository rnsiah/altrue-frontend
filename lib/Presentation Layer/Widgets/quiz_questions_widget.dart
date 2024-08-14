import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_answers_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_question_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_result_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/quiz_results_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/quiz_options_widget.dart';

import '../../Data Layer/Models/quiz_model.dart';
import '../../Data Layer/Models/user_model.dart';

class QuestionsWidget extends StatelessWidget {
  final Quiz quiz;
  final Profile profile;
  final int numOfCorrect;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final ValueChanged<QuizAnswers> onClickedOption;

  const QuestionsWidget({super.key, 
    
    required this.quiz,
    required this.profile,
    required this.controller,
    required this.onChangedPage,
    required this.onClickedOption,
    required this.numOfCorrect,
  });

  @override
  Widget build(BuildContext context) {
      final allQuestionsAnswered =
        quiz.questions.every((question) => question.isLocked);

    
    return PageView.builder(
        onPageChanged: onChangedPage,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        itemCount: quiz.questions.length ,
        itemBuilder: (context, index) {
          final question = quiz.questions[index];
          if(index<=quiz.questions.length){
            return buildQuestion(question: question,context: context, quizId: quiz.id,
          numOfCorrect: numOfCorrect, isLastQuestion:index ==quiz.questions.length-1);
          }else{
            return Center(
              child: ElevatedButton(child: const Text('results'), onPressed: (){
               
              },),
            );
          }
      
          
        },
      );
  } 

  Widget buildQuestion({

    required QuizQuestion question, required int numOfCorrect, required bool isLastQuestion, required BuildContext context, required int quizId
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              question.questionText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose your answer from below',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: OptionsWidget(
                question: question,
                onClickedOption: onClickedOption,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text('${numOfCorrect.toString()}/${quiz.questions.length} correct', style: const TextStyle(fontWeight: FontWeight.bold,),)),
              if(isLastQuestion) 
              ElevatedButton(onPressed: (){
               double theFinalScore = (
                (numOfCorrect/quiz.questions.length)* 100).roundToDouble();
               context.read<ProfileBloc>().add(SubmitQuizScore(
                quizResult: QuizResult(
                  numOfCorrect: numOfCorrect,
                  userId: profile.user!,
                  quizId: quizId,
                  score: theFinalScore
                  
                  )
                  )
                );
               Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>QuizResultsScreen(
                  quiz: quiz,
                  numOfCorrect: numOfCorrect, 
                  numOfQuestions: quiz.questions.length, 
                  profile: profile, 
                  finalScore:theFinalScore)));
            }, child: const Text('See results'))
          ],
        ),
      );
}
