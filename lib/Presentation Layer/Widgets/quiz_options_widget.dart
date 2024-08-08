import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_answers_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_question_model.dart';

import '../../utils.dart';

class OptionsWidget extends StatelessWidget {
  final QuizQuestion question;
  final ValueChanged<QuizAnswers> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: Utils.heightBetween(
          question.choices
              .map((option) => buildOption(context, option))
              .toList(),
          height: 8,
        ),
      );

  Widget buildOption(BuildContext context, QuizAnswers option) {
    final color = getColorForOption(option, question);

    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            buildAnswer(option),
            // buildSolution(question.selectedOption, option),
          ],
        ),
      ),
    );
  }

  Widget buildAnswer(QuizAnswers option) => SizedBox(
        height: 50,
        child: Row(children: [
          
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              option.answer,
              
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          )
        ]),
      );

  // Widget buildSolution(Option solution, Option answer) {
  //   if (solution == answer) {
  //     return Text(
  //       question.solution,
  //       style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  Color getColorForOption(QuizAnswers option, QuizQuestion question) {
    final isSelected = option == question.selectedOption;

    if (!isSelected) {
      return Colors.amber.shade200;
    } else {
      return option.isCorrect ? Colors.green : Colors.red;
    }
  }
}
