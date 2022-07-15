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
  int BossHP = 10;
  String result2 = 'BOSS HP';

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    // print(selectedHand);
    generateComputerHand();
    judge();
    bosshp();
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    ComputerHand = randomNumberToHand(randomNumber);
  }

  void judge() {
    if (result2 == '大勝利！！！ BOSSのHPは') {
      result2 = '新たなBOSSが現れた';
      BossHP = 10;
    }
    if (ComputerHand == myHand) {
      result = '引き分け';
    } else if (myHand == '✊' && ComputerHand == '✌') {
      result = '勝ち';
      BossHP -= 1;
    } else if (myHand == '✌' && ComputerHand == '✋') {
      result = '勝ち';
      BossHP -= 1;
    } else if (myHand == '✋' && ComputerHand == '✊') {
      result = '勝ち';
      BossHP -= 1;
    } else {
      result = '負け';
    }
  }

  void bosshp() {
    if (BossHP == 0) {
      result2 = '大勝利！！！ BOSSのHPは';
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // 勝敗
              Text(
                result2,
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              Text(
                BossHP.toString(),
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ]),
            SizedBox(
              height: 14,
            ),
            Text(
              result,
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // CPU Hand
              Text(
                'ComputerHand',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Text(
                ComputerHand,
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 70,
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // My Hand
              Text(
                'myHand',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              // My Hand
              Text(
                myHand,
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: OutlinedButton.styleFrom(minimumSize: Size(70, 70)),
                  onPressed: () {
                    selectHand(
                      '✊',
                    );
                  },
                  child: Text(
                    '✊',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(minimumSize: Size(70, 70)),
                  onPressed: () {
                    selectHand('✌');
                  },
                  child: Text(
                    '✌',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(minimumSize: Size(70, 70)),
                  onPressed: () {
                    selectHand('✋');
                  },
                  child: Text(
                    '✋',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
