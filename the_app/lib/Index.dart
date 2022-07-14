import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:the_app/Home.dart';
import 'package:the_app/screens/button.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:lottie/lottie.dart';
import "dart:async";

final titleFont = GoogleFonts.libreBaskerville(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  height: 1.55,
);

const inputStyle = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  labelStyle:
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
  ),
);

const hintstyle = TextStyle(color: Colors.white60, fontStyle: FontStyle.italic);

class NewLoginScreen extends StatefulWidget {
  @override
  _NewLoginScreen createState() => _NewLoginScreen();
}

class _NewLoginScreen extends State<NewLoginScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool isloading = false;

  @override
  build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body:
            // isloading
            // ? Center(child: CircularProgressIndicator())
            Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/banana3.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: isloading
                    ? Center(
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/private_files/lf30_vhn0noat.json"),
                      )
                    : Form(
                        key: formkey,
                        child: AnnotatedRegion<SystemUiOverlayStyle>(
                            value: SystemUiOverlayStyle.light,
                            child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: Lottie.network(
                                            "https://assets3.lottiefiles.com/private_files/lf30_vuxs5lpt.json"),
                                      ),
                                    ),
                                    Center(
                                        child: Text("The Banana Room",
                                            style: titleFont)),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        keyboardType: TextInputType.name,
                                        onChanged: (value) {
                                          email = value;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter your email";
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        decoration: inputStyle.copyWith(
                                          hintText: "Enter your email",
                                          hintStyle: hintstyle,
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        )),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter Password";
                                        }
                                      },
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: inputStyle.copyWith(
                                          hintText: 'Password',
                                          hintStyle: hintstyle,
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                          )),
                                    ),
                                    const SizedBox(height: 20),
                                    LoginSignupButton(
                                      title: 'Login',
                                      ontapp: () async {
                                        if (formkey.currentState!.validate()) {
                                          setState(() {
                                            isloading = true;
                                          });
                                          try {
                                            await _auth
                                                .signInWithEmailAndPassword(
                                                    email: email,
                                                    password: password);
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  // builder: (contex) => HomeScreen(),
                                                  builder: ((context) =>
                                                      UserHome())),
                                            );
                                            setState(() {
                                              isloading = false;
                                            });
                                          } on FirebaseAuthException catch (e) {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title:
                                                    Text("Ops! Login Failed"),
                                                content: Text('${e.message}'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('Okay'),
                                                  )
                                                ],
                                              ),
                                            );
                                            print(e);
                                          }
                                          setState(() {
                                            isloading = false;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ))))));
  }
}
