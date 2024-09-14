import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../Data Layer/Models/quiz_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Routers/functionality_router.dart';
import 'package:http/http.dart' as http;

class QuizListScreen extends StatefulWidget {
  final List<Quiz> quizes;
  final Profile profile;
  const QuizListScreen(
      {super.key, required this.quizes, required this.profile});

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {

  Future<bool> _shareQuiz(Quiz quiz, String imageUrl)async{
    final url = imageUrl;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final tempFile = File('${(await getTemporaryDirectory()).path}/temp_image.jpg');
    await tempFile.writeAsBytes(bytes);

    final result = await Share.shareXFiles(
    [XFile(tempFile.path)],
    text: quiz.description,
    );
    if (result.status == ShareResultStatus.unavailable) {
    print('Sharing is unavailable on this platform.');
    return false;
  } else if (result.status == ShareResultStatus.dismissed) {
    print('Share was dismissed.');
    return false;
  } else {
    print('Share was successful.');
    return true;
  }
  
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Image(image: AssetImage('images/Altrue Logo White.png')),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: widget.quizes.length,
              itemBuilder: (context, index) {
                Quiz quiz = widget.quizes[index];
                return Card(
                  color: Colors.black,
                  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // Set the clip behavior of the card
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // Define the child widgets of the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                      Container(
                        height: 160,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                scale: .3,
                                fit: BoxFit.fitHeight,
                                image: AssetImage('images/level 0.png'))),
                      ),
                      // Add a container with padding that contains the card's title, text, and buttons
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Display the card's title using a font size of 24 and a dark grey color
                            Text(
                              quiz.title,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.amber,
                              ),
                            ),
                            // Add a space between the title and the text
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Text(
                              quiz.description?? 'the best quiz ever',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            // Add a row with two buttons spaced apart and aligned to the right side of the card
                            Row(
                              children: <Widget>[
                                Text(
                                  'Reward:${quiz.action!.pointsAwarded.toString()} points',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                // Add a spacer to push the buttons to the right side of the card
                                const Spacer(),
                                // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "SHARE",
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                  onPressed: () async {
                                    final success = await _shareQuiz(quiz, 'imageUrl');
                                    if(success){
                                      profileBloc.add(ShareQuiz(quiz: quiz));
                                    }
                                  },
                                ),
                                // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "TAKE QUIZ",
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                  onPressed: () {
                                    context.go('/allProjectsList/quizpage',
                                        extra: QuizPageArguments(
                                            quiz: quiz,
                                            profile: widget.profile));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Add a small space between the card and the next widget
                      Container(height: 5),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
