import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_app/src/GoogleLogin.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = firebase_auth.FirebaseAuth.instance;

  final ImagePicker _picker = ImagePicker();
  firebase_auth.User? _user;

  bool isLoading = false;

  File? _photo;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String? avatar = _user?.photoURL;

  @override
  void initState() {
    super.initState();
    this._user = firebase_auth.FirebaseAuth.instance.currentUser;
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      isLoading = true;
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });

    final tmpUser = firebase_auth.FirebaseAuth.instance.currentUser;

    setState(() {
      isLoading = false;
      avatar = tmpUser?.photoURL;
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    // try {
    //   String url = '${_user?.photoURL}';
    //   firebase_storage.FirebaseStorage.instance.refFromURL(url).delete();
    // } catch (e) {
    //   print(e);
    // }

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      String imageURL = await ref.getDownloadURL();
      _user?.updatePhotoURL(imageURL);
      // _auth.currentUser
      print(imageURL);
    } catch (e) {
      print('error occured');
      print(e);
    }
  }

  void _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
            Center(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ))),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                  onTap: () {
                    // navigateSecondPage(EditImagePage());
                    _showPicker(context);
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(250, 222, 222, 57),
                        radius: 110,
                        child: _photo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  _photo!,
                                  width: 200,
                                  height: 200,
                                  // fit: BoxFit.fitHeight,
                                ),
                              )
                            : CircleAvatar(
                                // backgroundImage: NetworkImage(
                                //     'https://diamond-rm.net/wp-content/uploads/2020/10/980457ac46af26c09f3748d370ce3ab5-300x195.jpg'),
                                backgroundImage: NetworkImage('${avatar}'),
                                radius: 100,
                              ),
                      ),
                      Positioned(
                        child: buildEditIcon(Colors.black),
                        top: 15,
                        right: 20,
                      )
                    ],
                  )),
            ),
            buildUserInfoDisplay('${_auth.currentUser?.displayName}', 'Name'),
            buildUserInfoDisplay('${_auth.currentUser?.photoURL}', 'PhotoURL'),
            buildUserInfoDisplay('${_auth.currentUser?.email}', 'Email'),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Expanded(
                child: GoogleLoginButtton(),
                flex: 4,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          // navigateSecondPage(editPage);
                        },
                        child: Text(
                          getValue,
                          style: TextStyle(
                              color: Colors.blue, fontSize: 16, height: 1.4),
                        ))),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    // Route route = MaterialPageRoute(builder: (context) => editForm);
    // Navigator.push(context, route).then(onGoBack);
  }
}
