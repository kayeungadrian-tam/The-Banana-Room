import 'package:flutter/material.dart';
import 'dart:math';

class Add2List extends StatefulWidget {
  const Add2List({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Add2List> {
  final List<String> names = <String>[];
  final List<int> msgCount = <int>[];
  final List<int> players = <int>[];
  final List<bool> showItem = <bool>[];

  Random random = new Random();
  TextEditingController _textFieldController = TextEditingController();

  bool showButton = false;
  String codeDialog = "";
  String valueText = "";
  int currentValue = 0;

  String question = "駅の人気";
  String description = "人気度";

  Future<void> _displayTextInputDialog(BuildContext context, int index) async {
    _textFieldController.clear();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(description, style: TextStyle(fontSize: 22)),
                  Text('$currentValue',
                      style: TextStyle(
                        fontSize: 40,
                        color: currentValue > 80
                            ? Colors.green
                            : currentValue > 40
                                ? Colors.orange
                                : Colors.red,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )
            ]),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: ""),
            ),
            actions: <Widget>[
              IconButton(
                color: Colors.red,
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              IconButton(
                color: Colors.blue[900],
                icon: const Icon(Icons.check_circle),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    names.length == 0
                        ? names.insert(0, valueText)
                        : names.insert(index + 1, valueText);
                    msgCount.length == 0
                        ? msgCount.insert(0, currentValue)
                        : msgCount.insert(index + 1, currentValue);
                    players.length == 0
                        ? players.insert(0, 1)
                        : players.insert(index + 1, names.length);
                    showItem.length == 0
                        ? showItem.insert(0, false)
                        : showItem.insert(index + 1, false);
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(
                width: 15,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        // leading: Icon(Icons.menu),
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            const SizedBox(
              height: 12,
            ),
            Text(question,
                style: TextStyle(fontSize: 14, fontFamily: "Roboto")),
            const SizedBox(
              height: 12,
            ),
            Text('0: 気にならない <----> 100: 気になる',
                style: TextStyle(fontSize: 10, fontFamily: "Roboto")),
            const SizedBox(
              height: 12,
            ),
          ]),
        ]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu_open_sharp),
            onPressed: () {},
          )
        ],
      ),
      body: Column(children: <Widget>[
        SizedBox(height: 32),
        Row(
          children: [
            const SizedBox(
              width: 32,
            ),
          ],
        ),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.all(2),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                child: Center(
                                    child: Text("Player ${players[index]}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Roboto"))),
                              ),
                              Column(children: [
                                showButton
                                    ? IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          _displayTextInputDialog(
                                              context, index - 1);
                                        })
                                    : Container(),
                                Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        // _displayTextInputDialog(context);
                                        setState(() {
                                          showItem[index] = !showItem[index];
                                        });
                                      },
                                      child: Column(children: [
                                        SizedBox(
                                            width: 240,
                                            height: 100,
                                            child: ElevatedCardExample(
                                              title: "${names[index]}",
                                            ))
                                      ]),
                                    )),
                                index == names.length - 1
                                    ? showButton
                                        ? IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              _displayTextInputDialog(
                                                  context, index);
                                            })
                                        : const SizedBox()
                                    : const SizedBox(),
                              ]),
                              showItem[index]
                                  ? SizedBox(
                                      width: 60,
                                      child: Center(
                                          child: Text("${msgCount[index]}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Roboto"))),
                                    )
                                  : const SizedBox(),
                            ]),
                      ));
                }))
      ]),
      floatingActionButton: !showButton
          ? FloatingActionButton(
              onPressed: () => {
                {
                  setState(() {
                    names.length == 0
                        ? _displayTextInputDialog(context, 0)
                        : showButton = !showButton;
                    currentValue = random.nextInt(100);
                    // showButton = !showButton;
                  })
                },
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Center(
                        child: Text("Player ${names.length + 1}",
                            style: TextStyle(
                                fontSize: 32,
                                fontFamily: "Roboto",
                                decoration: TextDecoration.underline))),
                    content: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(description, style: TextStyle(fontSize: 22)),
                            Text('$currentValue',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: currentValue > 80
                                      ? Colors.green
                                      : currentValue > 40
                                          ? Colors.orange
                                          : Colors.red,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, 'OK'),
                        },
                        child: Center(
                          child: IconButton(
                            color: Colors.blue[900],
                            icon: const Icon(Icons.check_circle),
                            onPressed: () => {Navigator.pop(context)},
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.blue[400],
            )
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  names.length == 0
                      ? _displayTextInputDialog(context, 0)
                      : showButton = !showButton;
                  // showButton = !showButton;
                });
              },
              child: const Icon(Icons.clear),
              backgroundColor: Colors.red,
            ),
    );
  }
}

class ElevatedCardExample extends StatelessWidget {
  final String title;

  const ElevatedCardExample({Key? key, required this.title}) : super(key: key);

  // final title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text(title, style: TextStyle(fontSize: 32))),
        ),
      ),
    );
  }
}

/// An example of the filled card type.
///
/// To make a [Card] match the filled type, the default elevation and color
/// need to be changed to the values from the spec:
///
/// https://m3.material.io/components/cards/specs#0f55bf62-edf2-4619-b00d-b9ed462f2c5a
class FilledCardExample extends StatelessWidget {
  const FilledCardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Filled Card')),
        ),
      ),
    );
  }
}

/// An example of the outlined card type.
///
/// To make a [Card] match the outlined type, the default elevation and shape
/// need to be changed to the values from the spec:
///
/// https://m3.material.io/components/cards/specs#0f55bf62-edf2-4619-b00d-b9ed462f2c5a
class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Outlined Card')),
        ),
      ),
    );
  }
}
