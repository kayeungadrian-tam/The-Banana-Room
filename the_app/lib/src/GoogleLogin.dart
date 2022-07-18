import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_app/Home.dart';
import 'package:the_app/Index.dart';

import '../screens/button.dart';

class GoogleLoginButtton extends StatefulWidget {
  const GoogleLoginButtton({Key? key}) : super(key: key);

  @override
  _GoogleLoginButttonState createState() => _GoogleLoginButttonState();
}

class _GoogleLoginButttonState extends State<GoogleLoginButtton> {
  final _auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? _user;
  // If this._busy=true, the buttons are not clickable. This is to avoid
  // clicking buttons while a previous onTap function is not finished.
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    this._user = _auth.currentUser;
    _auth.authStateChanges().listen((firebase_auth.User? usr) {
      this._user = usr;
      debugPrint('user=$_user');
    });
  }

  Future<firebase_auth.User?> _googleSignIn() async {
    final curUser = this._user ?? _auth.currentUser;
    if (curUser != null && !curUser.isAnonymous) {
      return curUser;
    }
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
    final user = (await _auth.signInWithCredential(credential)).user;
    // kFirebaseAnalytics.logLogin();
    setState(() => this._user = user);
    return user;
  }

  Future<void> _signOut() async {
    final user = _auth.currentUser;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          user == null
              ? 'No user logged in.'
              : '"${user.displayName}" logged out.',
        ),
      ),
    );
    _auth.signOut();
    setState(() => this._user = null);
  }

  @override
  Widget build(BuildContext context) {
    final googleLoginBtn = MaterialButton(
      color: Colors.blueAccent,
      onPressed: this._busy
          ? null
          : () async {
              setState(() => this._busy = true);
              final user = await this._googleSignIn();

              // await Navigator.of(context).push(
              //   MaterialPageRoute(
              //       // builder: (contex) => HomeScreen(),
              //       builder: ((context) => UserHome())),
              // );

              // this._showUserProfilePage(user!);
              setState(() => this._busy = false);
            },
      child: LoginSignupButton(
        title: "Logout",
        ontapp: null,
      ),
    );

    final signOutBtn = LoginSignupButton(
      title: "Logout",
      ontapp: this._busy
          ? null
          : () async {
              setState(() => this._busy = true);
              await this._signOut();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NewLoginScreen()));
              setState(() => this._busy = false);
            },
    );

    return Center(
      child: Center(
        child: signOutBtn,
      ),
    );
  }
}
