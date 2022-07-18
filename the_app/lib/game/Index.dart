import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/src/core/constants/lotties.dart';

class GameIndexPage extends StatefulWidget {
  const GameIndexPage({Key? key}) : super(key: key);

  @override
  _GameIndexPageState createState() => _GameIndexPageState();
}

class _GameIndexPageState extends State<GameIndexPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
      ..value = 0
      ..addListener(() {
        setState(() {
          // Rebuild the widget at each frame to update the "progress" label.
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(child: const Text('Room 504')),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/banana2.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tap to start!",
                style: TextStyle(color: Colors.white, fontSize: 26)),
            SizedBox(
              height: 24,
            ),
            Lottie.network(
                "https://assets1.lottiefiles.com/packages/lf20_peau2zwt.json",
                width: 50,
                height: 50,
                frameRate: FrameRate(60)),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => _controller.forward(from: 0),
              child: Lottie.asset(
                door,
                controller: _controller,
                width: 380,
                height: 380,
                repeat: false,
                frameRate: FrameRate(60),
                onLoaded: (composition) {
                  setState(() {
                    // Configure the AnimationController with the duration of the Lottie composition.
                    _controller.duration = composition.duration;
                  });
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
