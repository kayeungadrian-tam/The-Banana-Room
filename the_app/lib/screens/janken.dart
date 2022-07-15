import 'package:flutter/material.dart';

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
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
            Text(
              '✊',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('✊');
                  },
                  child: Text('✊'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('✌');
                  },
                  child: Text('✌'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('✋');
                  },
                  child: Text('✋'),
                ),
              ],
            ),
          ],
        )));
  }
}
