import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class CustomDice extends StatelessWidget {
  final int diceNo;

  // This grid defines which place a dot will be placed and at which place there
  // won't be a dot. Because a dice has a grid of 3x3 and the dots only occur at
  // the places where the value in the following grid is true
  final List<List<bool>> _grid = [
    [true, false, true],
    [true, true, true],
    [true, false, true],
  ];

  // This defines the coordinates as per the above grid where the dot should occur
  // So if the dice rolls 1, then a dot should be placed in the row 1 column 1
  // (counting starts from 0) i.e. [1,1]
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

  // assert is simply a statement that says the value should satisfy the conditions
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

  // This controls the opacity of the visible dots
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