import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:math';

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

  int get _randDice => Random().nextInt(6) + 1;

  Widget _imgButton(int diceNo) => CustomDice(diceNo: diceNo);
}

class CustomDice extends StatelessWidget {
  final int diceNo;
  final List<List<bool>> _grid = [
    [true, false, true],
    [true, true, true],
    [true, false, true],
  ];

  final Map _data = {
    1: [
      [1, 1]
    ],
    2: [
      [2, 0],
      [0, 2]
    ],
    3: [
      [2, 0],
      [0, 2],
      [1, 1]
    ],
    4: [
      [2, 0],
      [0, 2],
      [2, 2],
      [0, 0]
    ],
    5: [
      [2, 0],
      [0, 2],
      [2, 2],
      [0, 0],
      [1, 1]
    ],
    6: [
      [2, 0],
      [0, 2],
      [2, 2],
      [0, 0],
      [1, 0],
      [1, 2]
    ],
  };

  CustomDice({@required this.diceNo}) : assert(diceNo >= 1 && diceNo <= 6);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < _grid.length; i++) {
      List<Widget> tmp = [];
      for (int j = 0; j < _grid[i].length; j++) {
        tmp.add(Opacity(
          opacity: _grid[i][j] && opacity(i, j) ? 1 : 0,
          child: _diceIndicator,
        ));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tmp,
      ));
    }
    Widget col = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rows,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.white, width: 16.0),
            ),
            child: Center(child: col)),
      ),
    );
  }

  bool opacity(int i, int j) {
    bool ret = false;
    for (List x in _data[diceNo]) {
      if (ListEquality().equals(x, [i, j])) {
        ret = true;
        break;
      }
    }
    return ret;
  }

  Widget get _diceIndicator => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: 20.0,
        height: 20.0,
      );
}
