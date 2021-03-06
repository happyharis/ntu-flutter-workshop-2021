import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: QuizPage(),
      routes: {
        'quiz': (context) => QuizPage(),
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool? chosenAnswer;
  int currentQuestionIndex = 0;
  bool haveAnswered = false;
  int points = 0;

  void awardPoint(Question question) {
    if (question.answer == chosenAnswer) {
      setState(() {
        points++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = questions[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == questions.length - 1;
    return Scaffold(
      body: Column(children: <Widget>[
        QuizBody(
          question: currentQuestion,
          chosenAnswer: chosenAnswer,
        ),
        if (haveAnswered)
          AnswerButton(
            color: Colors.grey.shade800,
            text: isLastQuestion ? "Let's see your score" : 'Next Question',
            onTap: () {
              if (!isLastQuestion) {
                setState(() {
                  currentQuestionIndex++;
                  haveAnswered = false;
                  chosenAnswer = null;
                });
              } else {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return ScoreScreen(
                      questionsAnswered: questions.length,
                      points: points,
                    );
                  },
                ), (route) => false);
              }
            },
          ),
        if (!haveAnswered)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                AnswerButton(
                  text: 'True',
                  color: Colors.green,
                  onTap: () {
                    setState(() {
                      chosenAnswer = true;
                      haveAnswered = true;
                      awardPoint(currentQuestion);
                    });
                  },
                ),
                AnswerButton(
                  text: 'False',
                  color: Colors.red,
                  onTap: () {
                    setState(() {
                      chosenAnswer = false;
                      haveAnswered = true;
                      awardPoint(currentQuestion);
                    });
                  },
                ),
              ],
            ),
          ),
      ]),
    );
  }
}

class ScoreScreen extends StatelessWidget {
  final int questionsAnswered;
  final int points;
  const ScoreScreen({
    required this.questionsAnswered,
    required this.points,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "You got $points out $questionsAnswered answers correct.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            AnswerButton(
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                'quiz',
                (route) => false,
              ),
              text: 'Play again!',
              color: Colors.indigo,
            )
          ],
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const AnswerButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        color: color,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizBody extends StatelessWidget {
  final bool? chosenAnswer;
  final Question question;
  const QuizBody({
    Key? key,
    this.chosenAnswer,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final youChoseText = "You chose $chosenAnswer. ";
    final haveChosenAnswer = chosenAnswer != null;
    final isCorrect = haveChosenAnswer && chosenAnswer == question.answer;
    final resultText = isCorrect ? "Correct!" : "Wrong!";
    final resultColor = isCorrect ? Colors.green : Colors.red;
    return Expanded(
      flex: 8,
      child: Container(
        padding: EdgeInsets.only(left: 20),
        width: screenWidth,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Question #${question.id}",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 5),
            Text(
              question.text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            if (haveChosenAnswer)
              Text(
                youChoseText + resultText,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final int id;
  final String text;
  final bool answer;

  Question({required this.id, required this.text, required this.answer});
}

final questions = [
  Question(id: 1, text: 'Haris is handsome.', answer: true),
  Question(id: 2, text: 'Flutter is easy.', answer: false),
  Question(id: 3, text: "I'm hungry", answer: true),
];
