import 'dart:math';

import 'package:flutter/material.dart';

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  String ComputerHand = '✊';
  String myHand = '✊';
  String result = '引き分け';

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    // print(selectedHand);
    generateComputerHand();
    judge();
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    ComputerHand = randomNumberToHand(randomNumber);
  }

  void judge() {
    if (ComputerHand == myHand) {
      result = '引き分け';
    } else if (myHand == '✊' && ComputerHand == '✌') {
      result = '勝ち';
    } else if (myHand == '✌' && ComputerHand == '✋') {
      result = '勝ち';
    } else if (myHand == '✋' && ComputerHand == '✊') {
      result = '勝ち';
    } else {
      result = '負け';
    }
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '✊';
      case 1:
        return '✌';
      case 2:
        return '✋';
      default:
        return '✊';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('じゃんけん'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 勝敗
            Text(
              result,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            // CPU Hand
            Text(
              ComputerHand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            // My Hand
            Text(
              myHand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand('✊');
                  },
                  child: Text('✊'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✌');
                  },
                  child: Text('✌'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✋');
                  },
                  child: Text('✋'),
                ),
              ],
            ),
          ],
        )));
  }
}
