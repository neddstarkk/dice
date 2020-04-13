import 'package:flutter/material.dart';
import 'dart:math';

import 'custom_dice.dart';

void main() => runApp(AppRoot());

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.blue.shade900,
          appBar: null,
          body: DicePage(),
        ),
      );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber;
  int rightDiceNumber;

  @override
  void initState() {
    leftDiceNumber = _randDice;
    rightDiceNumber = _randDice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Dice is nice'),
            centerTitle: true,
          ),
          Center(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => leftDiceNumber = _randDice),
                    child: _imgButton(leftDiceNumber),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => rightDiceNumber = _randDice),
                    child: _imgButton(rightDiceNumber),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  // This is a simple getter.
  int get _randDice => Random().nextInt(6) + 1;

  Widget _imgButton(int diceNo) => CustomDice(diceNo: diceNo);
}


