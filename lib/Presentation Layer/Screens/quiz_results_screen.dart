import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
     final bool passed = widget.finalScore >= 70;
    final String resultText = passed ? 'Congratulations!' : 'Keep Trying!';
    final String description = passed
        ? 'You passed the quiz and earned ${widget.quiz.action!.pointsAwarded} Altrue points.'
        : 'Don’t worry, you can always try again to improve your score.';

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/Altrue Logo White.png'),
                ),
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height*.05),
            // Result Text
            Text(
              resultText,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: passed ? Colors.amber : Colors.redAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Description Text
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Score Display
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: passed ? Colors.amber : Colors.redAccent,
                  width: 2,
                ),
              ),
              child: Text(
                'Your Score: ${widget.finalScore.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Action Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to home or another appropriate screen
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: passed ? Colors.amber : Colors.redAccent,
              ),
              child: Text(
                passed ? 'Continue' : 'Try Again',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}