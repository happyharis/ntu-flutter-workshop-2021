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
  bool isPlayerTurn = true;
  final tiles = List.generate(9, (_) => '');

  final winningTiles = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  String? winner;
  void checkWinner() {
    for (var answerIndexes in winningTiles) {
      final first = tiles[answerIndexes.first];
      final middle = tiles[answerIndexes[1]];
      final last = tiles[answerIndexes.last];
      if (first == middle &&
          middle == last &&
          first == last &&
          first.isNotEmpty) {
        setState(() => winner = isPlayerTurn ? 'X' : 'O');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final haveWinner = winner != null;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tic - Tac - Toe',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontFamily: 'Franchise',
                  ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              children: List.generate(
                tiles.length,
                (index) => OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.primaries[index],
                    side: BorderSide(width: 2, color: Colors.black),
                    shape: BeveledRectangleBorder(),
                  ),
                  child: Text(
                    haveWinner ? 'Winner is $winner' : tiles[index],
                    style: TextStyle(
                      fontSize: 110,
                      height: 1.1,
                      fontFamily: 'Franchise',
                    ),
                  ),
                  onPressed: () {
                    if (tiles[index].isNotEmpty || haveWinner) return;
                    setState(() {
                      tiles[index] = isPlayerTurn ? 'X' : 'O';
                      checkWinner();
                      isPlayerTurn = !isPlayerTurn;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
