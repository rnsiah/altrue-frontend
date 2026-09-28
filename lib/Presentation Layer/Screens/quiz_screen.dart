import 'package:flutter/material.dart';

import '../../Data Layer/Models/quiz_answers_model.dart';
import '../../Data Layer/Models/quiz_model.dart';
import '../../Data Layer/Models/quiz_question_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Widgets/questions_numbers_widget.dart';
import '../Widgets/quiz_questions_widget.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;
  final String quizId;
  final Profile profile;

  const QuizPage(
      {super.key,
      required this.quiz,
      required this.profile,
      required this.quizId});

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

  void resetQuiz() {
    setState(() {
      numOfCorrect = 0;
      for (var question in widget.quiz.questions) {
        question.isLocked = false;
        question.selectedOption = null;
      }
      question = widget.quiz.questions.first;
      controller.jumpToPage(0); // Jump to the first question
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.quiz.title,
              style: GlassmorphismTheme.h2Style.copyWith(
                color: GlassmorphismTheme.gold,
              ),
            ),
            Text(
              '${widget.quiz.action!.pointsAwarded!} Points',
              style: GlassmorphismTheme.captionStyle.copyWith(
                color: GlassmorphismTheme.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GlassIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.of(context).pop(),
          variant: GlassButtonVariant.glass,
        ),
        actions: [
          GlassIconButton(
            icon: Icons.filter_list,
            onPressed: () {},
            variant: GlassButtonVariant.glass,
          ),
          const SizedBox(width: GlassmorphismTheme.sm),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ]
                : [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress indicator
              GlassCard(
                margin: const EdgeInsets.all(GlassmorphismTheme.md),
                child: QuestionsNumberWidget(
                  questions: widget.quiz.questions,
                  question: question,
                  onClickedNumber: (index) =>
                      nextQuestion(index: index, jump: true),
                ),
              ),

              // Quiz content
              Expanded(
                child: QuestionsWidget(
                  profile: widget.profile,
                  quiz: widget.quiz,
                  controller: controller,
                  onChangedPage: (index) => nextQuestion(index: index),
                  onClickedOption: selectOption,
                  numOfCorrect: numOfCorrect,
                  onQuizComplete: resetQuiz,
                ),
              ),

              // Bottom controls
              GlassCard(
                margin: const EdgeInsets.all(GlassmorphismTheme.md),
                child: Row(
                  children: [
                    GlassButton(
                      text: 'Previous',
                      variant: GlassButtonVariant.secondary,
                      onPressed: controller.page != null && controller.page! > 0
                          ? () => controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              )
                          : null,
                      icon: Icons.arrow_back,
                    ),
                    const SizedBox(width: GlassmorphismTheme.md),
                    Expanded(
                      child: GlassCard(
                        hasGoldBorder: true,
                        child: Center(
                          child: Text(
                            'Score: $numOfCorrect/${widget.quiz.questions.length}',
                            style: GlassmorphismTheme.h3Style.copyWith(
                              color: GlassmorphismTheme.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: GlassmorphismTheme.md),
                    GlassButton(
                      text: 'Next',
                      variant: GlassButtonVariant.primary,
                      onPressed: controller.page != null &&
                              controller.page! <
                                  widget.quiz.questions.length - 1
                          ? () => controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              )
                          : null,
                      trailingIcon: Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectOption(QuizAnswers option) {
    if (question.isLocked) {
      return;
    } else {
      // if(option.isCorrect==true){
      //   numOfCorrect ++;
      //   print('correct answer');
      // }
      setState(() {
        if (option.isCorrect == true) {
          numOfCorrect++;
        }
        question.isLocked = true;
        question.selectedOption = option;
      });
    }
  }

  void nextQuestion({int? index, bool jump = false}) {
    final nextPage = controller.page! + 1;
    final indexPage = index ?? nextPage.toInt();

    setState(() {
      question = widget.quiz.questions[indexPage];
    });
    if (jump) {
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
