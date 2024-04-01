import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    const Quizzler(),
  );
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _State();
}

class _State extends State<QuizPage> {
  int questionNumber = 0;
  List<Icon> scoreKeeper = [];
  List<String> questions = [
    "You can lead a cow down stairs but not up stairs.",
    "Approximately one quarter of human bones are in the feet.",
    "A slug's blood is green.",
    "Bilal Ahmed Mirza is the best in the world."
  ];
  List<bool> answers = [false, true, true, true];

  bool isFinished() {
    if (scoreKeeper.length == answers.length) {
      return true;
    }
    return false;
  }

  void resetQuiz() {
    questionNumber = 0;
    scoreKeeper.clear();
  }

  void checkAnswers(bool userAnswer) {
    setState(
      () {
        if (isFinished()) {
          Alert(
            context: context,
            title: "Quizzler",
            desc: "You have finished the quiz.",
            buttons: [
              DialogButton(
                onPressed: () {
                  setState(
                    () {
                      resetQuiz();
                      Navigator.pop(context);
                    },
                  );
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ).show();
        } else {
          if (answers[questionNumber] == userAnswer) {
            scoreKeeper.add(
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
            );
          } else {
            scoreKeeper.add(
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          }
        }
      },
    );
  }

  void getNextQuestion() {
    setState(
      () {
        if (questionNumber < questions.length - 1) {
          questionNumber++;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              questions[questionNumber],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                checkAnswers(true);
                getNextQuestion();
              },
              child: const Text(
                "True",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                checkAnswers(false);
                getNextQuestion();
              },
              child: const Text(
                "False",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
