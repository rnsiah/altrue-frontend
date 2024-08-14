import 'package:flutter/material.dart';

import '../../Data Layer/Models/quiz_answers_model.dart';
import '../../Data Layer/Models/quiz_model.dart';
import '../../Data Layer/Models/quiz_question_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Widgets/questions_numbers_widget.dart';
import '../Widgets/quiz_questions_widget.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;
  final Profile profile;

  const QuizPage({super.key, required this.quiz, required this.profile});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late PageController controller;
  late QuizQuestion question;
  int numOfCorrect = 0;
 
  @override
  void initState() {
    super.initState();

    controller = PageController();
    question = widget.quiz.questions.first;
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar(context),
        body: QuestionsWidget(
          profile: widget.profile,
          quiz: widget.quiz,
          controller: controller,
          onChangedPage: (index) => nextQuestion(index: index),
          onClickedOption: selectOption,
          numOfCorrect: numOfCorrect,
        ),
      );

  AppBar buildAppBar(context) =>AppBar(
    centerTitle: false,
    title: Text(widget.quiz.title, style: TextStyle(color: Colors.white),),
    actions: const [
      Icon(Icons.filter),
      SizedBox(width: 16,)
      ],
      flexibleSpace: Container(decoration: const BoxDecoration(color: Colors.black),
      ),bottom: PreferredSize(preferredSize: const Size.fromHeight(80),
      child: Container(padding: const EdgeInsets.symmetric(vertical: 16),
      child: QuestionsNumberWidget(
        
        questions:widget.quiz.questions,
        question:question,
        onClickedNumber:(index)=>nextQuestion(index: index, jump:true)
      ),
      ),),);


  void selectOption(QuizAnswers option) {
    if (question.isLocked) {
      return;
    } else {
      // if(option.isCorrect==true){
      //   numOfCorrect ++;
      //   print('correct answer');
      // }
      setState(() {
           if(option.isCorrect ==true){
          numOfCorrect++;
        }
        question.isLocked = true;
        question.selectedOption = option;
     
      });
    }
  }

  void nextQuestion({int? index, bool jump =false}) {
    final nextPage = controller.page! + 1;
    final indexPage = index  ?? nextPage.toInt();
    

    setState(() {
      question = widget.quiz.questions[indexPage];
    });
    if(jump){
      controller.jumpToPage(indexPage);
    }
    final doneWithQuiz = 
      widget.quiz.questions.every((question) => question.isLocked);
      // if(doneWithQuiz){
      //   allQuestionsAnswered = true;
      // }

  // if (allQuestionsAnswered) {
    
  //     print('true');
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context)=>QuizResultsScreen(numOfCorrect: numOfCorrect, numOfQuestions: widget.quiz.questions.length, profile: widget.profile)));
  //   }else{
  //     print('not done');
  //   }
  }
}
