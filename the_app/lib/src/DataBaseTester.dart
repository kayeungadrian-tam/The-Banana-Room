import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class RealtimeDatabase extends StatefulWidget {
  @override
  State<RealtimeDatabase> createState() => _RealtimeDatabaseState();
}

class _RealtimeDatabaseState extends State<RealtimeDatabase> {
  firebase_auth.User? _user;
  late DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    this.databaseReference = FirebaseDatabase.instance.ref().child("messages");
    this._user = firebase_auth.FirebaseAuth.instance.currentUser;
  }

  final TextEditingController _textController = TextEditingController();
  String address = "";

  Widget _buildMessagesList() {
    return Flexible(
      child: Scrollbar(
        child: FirebaseAnimatedList(
          defaultChild: const Center(child: CircularProgressIndicator()),
          query: databaseReference,
          sort: (a, b) => b.key!.compareTo(a.key!),
          padding: const EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (
            BuildContext ctx,
            DataSnapshot snapshot,
            Animation<double> animation,
            int idx,
          ) =>
              _messageFromSnapshot(snapshot, animation),
        ),
      ),
    );
  }

  Widget _messageFromSnapshot(
    DataSnapshot snapshot,
    Animation<double> animation,
  ) {
    final val = snapshot.value;
    if (val == null) {
      return Container();
    }
    final json = val as Map;
    final senderName = json['name'] as String? ?? '?? <unknown>';
    final msgText = json['text'] as String? ?? '??';
    final sentTime = json['timestamp'] as int? ?? 0;
    // final senderPhotoUrl = json['senderPhotoUrl'] as String?;
    final messageUI = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              child: Text(senderName[0]),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(senderName),
                Text(
                  msgText,
                  style: TextStyle(fontSize: 21),
                ),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(sentTime).toString(),
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: messageUI,
    );
  }

  @override
  Widget build(BuildContext context) {
    // readData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Realtime Database Demo'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildMessagesList(),
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'borderless input',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                  ),
                  onPressed: () => sendMessage(_textController.text),
                ),
              ),
              controller: _textController,
              onChanged: (String text) => print(text),
            ),
          ],
        ),
      )), //center
    );
  }

  Future<void> sendMessage(String text) async {
    _textController.clear();
    databaseReference.push().set({
      "name": "${_user?.displayName}",
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "text": text
    });
  }

  void createData() {
    databaseReference
        .child("flutterDevsTeam1")
        .set({'name': 'Deepak Nishad', 'description': 'Team Lead'});
    databaseReference.child("flutterDevsTeam2").set(
        {'name': 'Yashwant Kumar', 'description': 'Senior Software Engineer'});
    databaseReference
        .child("flutterDevsTeam3")
        .set({'name': 'Akshay', 'description': 'Software Engineer'});
    databaseReference
        .child("flutterDevsTeam4")
        .set({'name': 'Aditya', 'description': 'Software Engineer'});
    databaseReference
        .child("flutterDevsTeam5")
        .set({'name': 'Shaiq', 'description': 'Associate Software Engineer'});
    databaseReference
        .child("flutterDevsTeam6")
        .set({'name': 'Mohit', 'description': 'Associate Software Engineer'});
    databaseReference
        .child("flutterDevsTeam7")
        .set({'name': 'Naveen', 'description': 'Associate Software Engineer'});
  }

  void readData() {
    // DatabaseReference tmp = FirebaseDatabase.instance.ref("user");
    setState(() {
      databaseReference.onValue.listen((DatabaseEvent event) {
        final val = event.snapshot.value;
        final data = val as Map;
        debugPrint('>> ${data["address"]}');
        address = data["address"]["line1"];
      });
    });
  }

  void updateData() {
    databaseReference.child('flutterDevsTeam1').update({'description': 'CEO'});
    databaseReference
        .child('flutterDevsTeam2')
        .update({'description': 'Team Lead'});
    databaseReference
        .child('flutterDevsTeam3')
        .update({'description': 'Senior Software Engineer'});
  }

  void deleteData() {
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }
}
