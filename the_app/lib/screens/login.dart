import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:nanoid/nanoid.dart';

import '../constant.dart';
import 'button.dart';
import 'home.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

  List<DocumentSnapshot> documentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.grey[100],
      body: Center(
          child: isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: formkey,
                  child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.dark,
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/abstract.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: double.infinity,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 120),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "The Banana Game",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 30),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter Email";
                                    }
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                TextFormField(
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
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      )),
                                ),
                                SizedBox(height: 80),
                                ElevatedButton(
                                  child: Text('コレクション＋ドキュメント作成'),
                                  onPressed: () async {
                                    // ドキュメント作成
                                    await FirebaseFirestore.instance
                                        .collection(
                                            'test_collection') // コレクションID
                                        .doc('${nanoid(10)}') // ドキュメントID
                                        .set({
                                      'name': '${email}',
                                      // 'age': 20
                                    }); // データ
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('ドキュメント一覧取得'),
                                  onPressed: () async {
                                    // コレクション内のドキュメント一覧を取得
                                    final snapshot = await FirebaseFirestore
                                        .instance
                                        .collection('users')
                                        .get();
                                    // 取得したドキュメント一覧をUIに反映
                                    setState(() {
                                      documentList = snapshot.docs;
                                    });
                                  },
                                ),
                                // コレクション内のドキュメント一覧を表示
                                Column(
                                  children: documentList.map((document) {
                                    return ListTile(
                                      title: Text('${document['name']}さん'),
                                      subtitle: Text('${document['age']}歳'),
                                      trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                          onPressed: () async {
                                            // ドキュメント削除
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(document.id)
                                                .delete();
                                          }),
                                    );
                                  }).toList(),
                                ),
                                Lottie.network(
                                    'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),

                                LoginSignupButton(
                                  title: 'Login',
                                  ontapp: () async {
                                    if (formkey.currentState!.validate()) {
                                      setState(() {
                                        isloading = true;
                                      });
                                      try {
                                        await _auth.signInWithEmailAndPassword(
                                            email: email, password: password);

                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              // builder: (contex) => HomeScreen(),
                                              builder: ((context) =>
                                                  IndexPageState())),
                                        );

                                        setState(() {
                                          isloading = false;
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text("Ops! Login Failed"),
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
                                SizedBox(height: 30),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Don't have an Account ?",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87),
                                      ),
                                      SizedBox(width: 10),
                                      Hero(
                                        tag: '1',
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }
}
