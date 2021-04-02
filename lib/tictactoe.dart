import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'dart:math' as math;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  var matrix = new List.generate(3, (_) => new List.filled(3, ""));
  var colorMatrix = new List.generate(
    3,
    (_) => new List.filled(
      3,
      Colors.grey[200],
    ),
  );

  // var _color = Colors.grey[200];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: SafeArea(
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            backgroundColor: Colors.grey[200],
            // automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Text(
                "TIC TAC TOE",
                style: GoogleFonts.montserrat(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                ),
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100.0),
      ),
      body: Center(
        child: Container(
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 100.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildElement(0, 0),
                        _buildElement(0, 1),
                        _buildElement(0, 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildElement(1, 0),
                        _buildElement(1, 1),
                        _buildElement(1, 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildElement(2, 0),
                        _buildElement(2, 1),
                        _buildElement(2, 2),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0)),
                  // padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey[200]),
                  // backgroundColor: Colors.grey[200],
                ),
                onPressed: () {
                  Phoenix.rebirth(context);
                  Fluttertoast.showToast(
                    msg: "GAME RESET",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.black87,
                    backgroundColor: Colors.grey[200],
                  );
                },
                child: Text(
                  "RESET",
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 18.0,
                    // fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  Color _getColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }

  */

  String _lastChar = 'O';

  _changeMatrixField(int i, int j) {
    setState(() {
      if (matrix[i][j] == '') {
        if (_lastChar == 'O') {
          matrix[i][j] = 'X';
          colorMatrix[i][j] = Colors.redAccent;
          // _color = Colors.redAccent;
        } else {
          matrix[i][j] = 'O';
          colorMatrix[i][j] = Colors.amberAccent;
          // _color = Colors.amberAccent;
        }
        _lastChar = matrix[i][j];
      }
    });
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = matrix.length - 1;
    var player = matrix[x][y];

    for (var i = 0; i < matrix.length; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i] == player) rdiag++;
    }

    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      returnAD("$player WON!!");
    } else {
      if (isTie()) {
        returnAD("IT\'S A TIE!!");
      }
    }
  }

  void returnAD(String msg) {
    Timer(
      Duration(milliseconds: 100),
      () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.grey[200],
              title: Center(
                child: Text(
                  msg,
                  // '$player won!!',
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black87),
                    ),
                    onPressed: () {
                      Phoenix.rebirth(context);
                    },
                    child: Text(
                      "PLAY AGAIN",
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              // actions: [

              // ],
            );
          },
        );
      },
    );
  }

  bool isTie() {
    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == "") {
          return false;
        }
      }
    }
    return true;
  }

  Widget _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);
        _checkWinner(i, j);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: colorMatrix[i][j],
        ),
        width: 100.0,
        height: 100.0,
        child: Center(
          child: Text(
            matrix[i][j],
            style: TextStyle(
              fontSize: 50.0,
              color: matrix[i][j] == 'X' ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
