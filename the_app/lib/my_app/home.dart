import 'package:flutter/material.dart';
import 'package:the_app/my_app/janken.dart';

class chenge_app extends StatefulWidget {
  const chenge_app({Key? key}) : super(key: key);

  @override
  State<chenge_app> createState() => _JankenPageState();
}

class _JankenPageState extends State<chenge_app> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('アプリ選択'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.black87.withOpacity(0.6)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(50.20)),
                  ),
                  onPressed: () {
                    print('じゃんけん');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JankenPage()));
                  },
                  child: Text('             じゃんけん             '),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.yellowAccent.withOpacity(0.9)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(50.20)),
                  ),
                  onPressed: () {
                    print('じゃんけん');
                  },
                  child: Text('next game comming soon'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue.withOpacity(0.6)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(50.20)),
                  ),
                  onPressed: () {
                    print('じゃんけん');
                  },
                  child: Text('next game comming soon'),
                ),
              ],
            ),
          ],
        )));
  }
}
