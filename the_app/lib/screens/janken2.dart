import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const JankenApp());
}

class JankenApp extends StatelessWidget {
  const JankenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'じゃんけん',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const JankanPage(title: 'じゃんけんアプリ'),
    );
  }
}

class JankanPage extends StatefulWidget {
  const JankanPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<JankanPage> createState() => _JankanPageState();
}

class _JankanPageState extends State<JankanPage> {
  final List<String> _janken = ['✊', '✌️', '🖐'];
  final math.Random _rand = math.Random();
  String _handForm = '👐';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _handForm,
              style: Theme.of(context).textTheme.headline1,
            ),
            ElevatedButton(
              child: const Text('じゃんけんぽん'),
              onPressed: () {
                setState(() {
                  _handForm = _janken[_rand.nextInt(_janken.length)];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
