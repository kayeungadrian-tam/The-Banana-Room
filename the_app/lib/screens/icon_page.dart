import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_app/src/core/constants/app_theme.dart';
import 'package:the_app/src/core/constants/lotties.dart';
import 'package:the_app/src/core/theme/theme.dart';
// import 'package:the_app/src/pages/widgets/biometrics_page.dart';

import 'package:the_app/screens/cardtemplate.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int previousIndex = 0;

  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;
  late AnimationController onChangedAnimation;

  String _label = 'Notification';
  final _titles = ['Notification', 'BookMark', 'Like'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      onSelectedAnimation.reset();
      onSelectedAnimation.forward();

      onChangedAnimation.value = 1;
      onChangedAnimation.reverse();

      setState(() {
        previousIndex = _selectedIndex;
        _selectedIndex = index;
        _label = _titles[index];
      });
    });
  }

  Duration animationDuration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    onChangedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    super.dispose();
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    onChangedAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lottie Practice',
          style: filterByTitleStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const transitionDuration = Duration(milliseconds: 400);

          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: transitionDuration,
              reverseTransitionDuration: transitionDuration,
              pageBuilder: (_, animation, ___) {
                return FadeTransition(
                  opacity: animation,
                  child: null,
                );
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: Column(children: [
        Text(_label, style: productNameStyle),
        Text(""),
        MyCard(text: "testing"),
        // MyCard()
      ])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Lottie.asset(bellNotification,
                width: 60,
                height: 60,
                frameRate: FrameRate(60),
                repeat: false,
                controller: _selectedIndex == 0
                    ? onSelectedAnimation
                    : previousIndex == 0
                        ? onChangedAnimation
                        : idleAnimation),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset(rocket,
                width: 60,
                height: 60,
                frameRate: FrameRate(60),
                repeat: false,
                controller: _selectedIndex == 1
                    ? onSelectedAnimation
                    : previousIndex == 1
                        ? onChangedAnimation
                        : idleAnimation),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset(likeNoBackground,
                width: 60,
                height: 60,
                frameRate: FrameRate(60),
                repeat: false,
                controller: _selectedIndex == 2
                    ? onSelectedAnimation
                    : previousIndex == 2
                        ? onChangedAnimation
                        : idleAnimation),
            label: '',
          ),
        ],
      ),
    );
  }
}
