import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_app/main.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

import 'dart:io';
import 'dart:async';
import 'package:the_app/sandbox/puzzle_page.dart';
import 'package:the_app/sandbox/list_dragdrop.dart';
import 'package:the_app/sandbox/add_to_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have logged in Successfuly'),
            SizedBox(height: 50),
            Container(
              height: 60,
              width: 150,
              child: ElevatedButton(
                  clipBehavior: Clip.hardEdge,
                  child: Center(
                    child: Text('Log out'),
                  ),
                  onPressed: () async {
                    await _signOut();
                    if (_firebaseAuth.currentUser == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class IndexPageState extends StatelessWidget {
  const IndexPageState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('HOME PAGE'),
          actions: [
            IconButton(
              onPressed: () async {
                await _signOut();
                if (_firebaseAuth.currentUser == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topRight,
              //   end: Alignment.bottomLeft,
              //   colors: [
              //     Color.fromARGB(245, 254, 250, 166),
              //     Color.fromARGB(251, 100, 163, 205),
              //   ],
              // ),
              image: DecorationImage(
                image: AssetImage("assets/images/abstract.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Text("The Banana Game", style: TextStyle(fontSize: 32)),
                  const SizedBox(height: 50),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => showPage(context, const PuzzlePage()),
                        // onPressed: () => showHomePage(context),
                        child: const Text(
                          "Puzzle",
                          style: TextStyle(fontSize: 22),
                        ),
                      )),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        // onPressed: () => showPuzzlePage(context),
                        onPressed: () => showPage(context, const HomePage()),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown[500],
                          textStyle: const TextStyle(fontSize: 32),
                        ),
                        child: const Text(
                          "List D&D",
                          style: TextStyle(fontSize: 22),
                        ),
                      )),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        // onPressed: () => showPuzzlePage(context),
                        onPressed: () => showPage(
                            context, const MyHomePage(title: "My Dashboard")),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan[200],
                          textStyle: const TextStyle(fontSize: 32),
                        ),
                        child: const Text(
                          "Home",
                          style: TextStyle(fontSize: 22),
                        ),
                      )),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        // onPressed: () => showPuzzlePage(context),
                        onPressed: () => showPage(context, const Add2List()),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[900],
                          textStyle: const TextStyle(fontSize: 32),
                        ),
                        child: const Text(
                          "Add2List",
                          style: TextStyle(fontSize: 22),
                        ),
                      )),
                ]))));
  }
}

void showPage(BuildContext context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  // State<MyHomePage> createState() => _MyHomePageState();
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selected Image',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 300,
                  child: _pickedImage == null
                      ? Text('')
                      : Image.file(_pickedImage!)),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text("Starting"),
            const SizedBox(height: 24),
            ElevatedButton(
              // onPressed: () => {},
              onPressed: () async {
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile == null) {
                  return;
                }
                setState(() {
                  _pickedImage = File(pickedFile.path);
                });
              },
              child: const Text('選ぶ'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
