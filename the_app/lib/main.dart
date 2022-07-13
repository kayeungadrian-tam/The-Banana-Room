import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_app/my_app/home.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.amber,
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
);

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink)
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final _dark = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: _lightTheme,
        // home: const MyHomePage(title: 'The Banana Game'),
        // home: const IndexPageState());
        // home: LoginScreen());
        // home: JankenPage(),
        // );
        // home: const AppPage(),
        // home: NewLoginScreen());
        home: chenge_app());
  }
}
