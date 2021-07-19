import 'package:flutter/material.dart';

// import 'answer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
            9,
            (index) => OutlinedButton(
              onPressed: () {},
              child: Text('X'),
            ),
          ),
        ),
      ),
    );
  }
}
