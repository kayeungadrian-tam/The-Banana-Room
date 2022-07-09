import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:the_app/sandbox/puzzle_page.dart';
import 'package:the_app/sandbox/list_dragdrop.dart';
import 'package:the_app/sandbox/add_to_list.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/icon_page.dart';

import 'Index.dart';

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
        // home: const IndexPageState(),
        // home: LoginScreen(),
        // home: const AppPage(),
        home: NewLoginScreen());
  }
}
