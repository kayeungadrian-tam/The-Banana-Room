import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_app/Dashboard.dart';
import 'package:the_app/Web_test.dart';
import 'package:the_app/pages/profile_page.dart';
import 'package:the_app/sandbox/puzzle_page.dart';
import 'package:the_app/src/DataBaseTester.dart';
import 'package:the_app/src/core/constants/lotties.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'game/Index.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int previousIndex = 0;

  // int _currentTabIndex = 0;

  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;
  late AnimationController onChangedAnimation;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // _currentTabIndex = index;
      onSelectedAnimation.reset();
      onSelectedAnimation.forward();
      onChangedAnimation.value = 1;
      onChangedAnimation.reverse();
      setState(() {
        previousIndex = _selectedIndex;
        _selectedIndex = index;
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
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    onChangedAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      DashboardPage(),
      PuzzlePage(),
      Container(),
      RealtimeDatabase(),
      ProfilePage(),
    ];
    var _kBottmonNavBarItems = <BottomNavigationBarItem>[
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
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
        items: _kBottmonNavBarItems,
        backgroundColor: const Color.fromARGB(220, 247, 232, 211),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped);

    return Scaffold(
        // body: TabBarView(
        //   controller: _tabController,
        //   children: _kTabPages,
        // ),
        // bottomNavigationBar: Material(
        //   color: Colors.amber[400],
        //   child: TabBar(
        //     tabs: _kTabs,
        //     controller: _tabController,
        //   ),
        // ),
        body: _kTabPages[_selectedIndex],
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: CurvedNavigationBar(
              color: Colors.yellow[200]!.withOpacity(0.5),
              backgroundColor: Colors.grey.withOpacity(0.7),
              buttonBackgroundColor: Colors.yellow,
              height: 50,
              items: const <Widget>[
                Icon(Icons.home, size: 26, color: Colors.black),
                Icon(Icons.gamepad_rounded, size: 26, color: Colors.black),
                Icon(Icons.door_front_door_outlined,
                    size: 40, color: Colors.black),
                Icon(Icons.chat, size: 26, color: Colors.black),
                Icon(Icons.person, size: 26, color: Colors.black),
              ],
              animationDuration: const Duration(microseconds: 200),
              index: 0,
              animationCurve: Curves.bounceInOut,
              onTap: (int index) async {
                // debugPrint("Current Index is $index");
                if (index == 2) {
                  await Navigator.of(context).push(
                    // MaterialPageRoute(
                    // builder: (contex) => HomeScreen(),
                    // builder: ((context) => GameIndexPage())),
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => GameIndexPage(),
                      transitionsBuilder: (c, anim, a2, child) =>
                          FadeTransition(opacity: anim, child: child),
                      transitionDuration: const Duration(milliseconds: 500),
                    ),

                    // ),
                  );
                } else {}
                _onItemTapped(index);
              },
            )));
  }
}
