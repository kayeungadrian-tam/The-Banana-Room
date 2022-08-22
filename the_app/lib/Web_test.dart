import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:lottie/lottie.dart';
import 'dart:io';

class WebSocketPage extends StatefulWidget {
  const WebSocketPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<WebSocketPage> createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  final TextEditingController _controller = TextEditingController();
  // late WebSocketChannel _channel;
  firebase_auth.User? _user;
  List<String> messages = [];
  int totalPlayers = 0;
  String name = "";
  String roomNumber = "101";

  Stream<QuerySnapshot>? _usersStream;

  Stream<QuerySnapshot>? _roomsStream;

  @override
  void initState() {
    super.initState();

    _roomsStream = FirebaseFirestore.instance.collection("Rooms").snapshots();

    _usersStream = FirebaseFirestore.instance
        .collection('Rooms')
        .doc("${roomNumber}")
        .collection("players")
        .snapshots();

    this._user = firebase_auth.FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return ListeningW();
  }

  Widget Tite(String room, String host) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text('Room ${room}'),
        subtitle: Text('by ${host}'),
        onTap: () => _enter(room),
      ),
    );
  }

  Widget ListeningW() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
                "https://assets10.lottiefiles.com/private_files/lf30_vhn0noat.json"),
          );
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
                child: Text(
                    "Room: ${roomNumber}, (${snapshot.data!.docs.length})")),
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Rooms(),
                  Text(
                    "Member",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Container(
                        height: 250,
                        child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot doc) {
                                Map<String, dynamic> data =
                                    doc.data()! as Map<String, dynamic>;
                                return ListTile(
                                  title: Text(data["name"]),
                                  // subtitle: Text(data['company']),
                                );
                              })
                              .toList()
                              .cast(),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    child: TextFormField(
                      controller: _controller,
                      decoration:
                          const InputDecoration(labelText: 'Room number'),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                      onPressed: _createRoom, child: Text("Create Room")),
                  Text("DisplayName: ${_user?.displayName}")
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _sendMessage,
            tooltip: 'Send message',
            child: const Icon(Icons.send),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  Widget Rooms() {
    return StreamBuilder<QuerySnapshot>(
      stream: _roomsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Text('Loading...');
        return Container(
          height: 200,
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Tite('${document.id}', '${document["name"]}');
            }).toList(),
          ),
        );
      },
    );
  }

  void _createRoom() async {
    await FirebaseFirestore.instance
        .collection("Rooms")
        .doc("${name}")
        .set({"name": "${_user?.displayName}"});
    await FirebaseFirestore.instance
        .collection("Rooms")
        .doc("${name}")
        .collection("players")
        .doc("${name}_id")
        .set({"name": "${_user?.displayName}"});
    // setState(() {
    // name = "";
    // });
    // _controller.clear();
  }

  void _enter(String room) async {
    setState(() {
      roomNumber = room;
      FirebaseFirestore.instance
          .collection("Rooms")
          .doc("${room}")
          .collection("players")
          .doc("${name}_id")
          .set({"name": "${_user?.displayName}"});
      _usersStream = FirebaseFirestore.instance
          .collection('Rooms')
          .doc("${room}")
          .collection("players")
          .snapshots();
    });
  }

  void _sendMessage() {
    setState(() {
      roomNumber = "102";
      _usersStream = FirebaseFirestore.instance
          .collection('Rooms')
          .doc("${roomNumber}")
          .collection("players")
          .snapshots();
    });

    _controller.clear();
  }

  @override
  void dispose() {
    // _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
