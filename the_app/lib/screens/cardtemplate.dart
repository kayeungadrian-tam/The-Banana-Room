import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final text;

  MyCard({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 150,
            width: 100,
            color: Colors.red,
            child: Text("${text}"),
          ),
        ));
  }
}
