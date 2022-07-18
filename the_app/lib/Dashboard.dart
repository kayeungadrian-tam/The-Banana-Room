import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Offset _offset = Offset.zero;
  Offset _offset2 = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final testCard = FlipCard(
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      front: Container(
        child: SizedBox(
          height: 250,
          width: 200,
          child: Image(
              image: NetworkImage(
                  'https://m.media-amazon.com/images/I/61FJGiJCVlL._AC_SL1024_.jpg')),
        ),
      ),
      back: Container(
        child: SizedBox(
          height: 250,
          width: 200,
          child: Image(
              image: NetworkImage(
                  'https://i.pinimg.com/originals/16/88/bc/1688bcd43697602edcae25bc667bf336.jpg')),
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Center(child: Text('Dashbaord')),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Lottie.network(
                  "https://assets1.lottiefiles.com/packages/lf20_qjtiav2l.json",
                  height: 250),
            ),
            const SizedBox(
              height: 42,
            ),
            Row(
              children: [
                SizedBox(
                  height: 250,
                  width: 200,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // perspective
                      ..rotateX(0.01 * _offset2.dy) // changed
                      ..rotateY(-0.01 * _offset2.dx), // changed
                    alignment: FractionalOffset.center,
                    child: GestureDetector(
                      // new
                      onPanUpdate: (details) =>
                          setState(() => _offset2 += details.delta),
                      onDoubleTap: () => setState(() => _offset2 = Offset.zero),
                      child: const FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 0.9,
                        child: Image(
                            image: NetworkImage(
                                'https://m.media-amazon.com/images/I/61FJGiJCVlL._AC_SL1024_.jpg')),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  width: 200,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // perspective
                      ..rotateX(0.01 * _offset.dy) // changed
                      ..rotateY(-0.01 * _offset.dx), // changed
                    alignment: FractionalOffset.center,
                    child: GestureDetector(
                      // new
                      onPanUpdate: (details) =>
                          setState(() => _offset += details.delta),
                      onDoubleTap: () => setState(() => _offset = Offset.zero),
                      child: const FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 0.9,
                        child: Image(
                            image: NetworkImage(
                                'https://teamcovenant.com/wp-content/uploads/2019/06/pikachu.jpg')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            testCard
          ],
        )),
      )),
    );
  }
}
