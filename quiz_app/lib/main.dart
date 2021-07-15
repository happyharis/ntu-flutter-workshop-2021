import 'package:flutter/material.dart';

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
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questions = [
    Question('Haris is handsome', true, 1),
    Question('Flutter is easy', false, 2),
    Question("I'm hungry", true, 3),
  ];

  bool haveAnswered = false;
  bool? chosenAnswer;
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      body: Column(children: <Widget>[
        QuizBody(question: currentQuestion, chosenAnswer: chosenAnswer),
        if (haveAnswered)
          AnswerButton(
            onTap: () {
              setState(() {
                haveAnswered = false;
                chosenAnswer = null;
                currentQuestionIndex =
                    (currentQuestionIndex + 1) % questions.length;
              });
            },
            text: 'Next Question',
            color: Colors.grey.shade800,
          ),
        if (!haveAnswered)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                AnswerButton(
                  onTap: () {
                    setState(() {
                      chosenAnswer = true;
                      haveAnswered = true;
                    });
                  },
                  text: 'True',
                  color: Colors.green,
                ),
                AnswerButton(
                  onTap: () {
                    setState(() {
                      chosenAnswer = false;
                      haveAnswered = true;
                    });
                  },
                  text: 'False',
                  color: Colors.red,
                ),
              ],
            ),
          ),
      ]),
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.color,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color color;

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
  final Question question;
  const QuizBody({
    Key? key,
    required this.question,
    required this.chosenAnswer,
  }) : super(key: key);

  final bool? chosenAnswer;

  @override
  Widget build(BuildContext context) {
    final isCorrect = chosenAnswer != null && chosenAnswer == question.answer;
    final isWrong = chosenAnswer != null && chosenAnswer != question.answer;
    final youChooseText = "You chose $chosenAnswer. ";
    return Expanded(
      flex: 8,
      child: Container(
        padding: EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            if (isCorrect)
              Text(
                youChooseText + 'Correct!',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            if (isWrong)
              Text(
                youChooseText + 'Wrong!',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final bool answer;
  final int id;

  Question(this.text, this.answer, this.id);
}
