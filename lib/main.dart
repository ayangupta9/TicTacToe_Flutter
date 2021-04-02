import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tictactoe/tictactoe.dart';

void main() {
  runApp(
    Phoenix(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TIC TAC TOE",
        home: TicTacToe(),
      ),
    ),
  );
}
