import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  // 現在のタイルの状態
  List<int> tileNumbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    0,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Center(child: const Text('スライドパズル')),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          // 保存したタイルの状態を読zみ込むボタン
          IconButton(
            onPressed: () => loadTileNumbers(),
            icon: const Icon(Icons.play_arrow),
          ),
          // 現在のタイルの状態を保存するボタン
          IconButton(
            onPressed: () => saveTileNumbers(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // タイル一覧
            Expanded(
              child: Center(
                child: TilesView(
                  numbers: tileNumbers,
                  isCorrect: calcIsCorrect(tileNumbers),
                  // タップしたら入れ替える
                  onPressed: (number) => swapTile(number),
                ),
              ),
            ),
            // シャッフルボタン
            SizedBox(
              width: double.infinity,
              height: 52,
              child: Container(
                height: 50,
                // color: Color.fromARGB(145, 255, 235, 57),
                child: ElevatedButton(
                  onPressed: () => shuffleTiles(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    'Shuffle',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),

                // ElevatedButton.icon(
                //   onPressed: () => shuffleTiles(),
                //   icon: const Icon(Icons.shuffle),
                //   label: const Text('シャッフル'),
                // )
              ),
            ),
          ],
        ),
      ),
    );
  }

  // タイルが正解であるか
  bool calcIsCorrect(List<int> numbers) {
    final correctNumbers = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      0,
    ];
    for (int i = 0; i < correctNumbers.length; i++) {
      if (numbers[i] != correctNumbers[i]) {
        return false;
      }
    }
    return true;
  }

  // タップしたタイルと空白を入れ替える
  void swapTile(int number) {
    // タップしたタイルと空白が隣り合っている場合のみ入れ替える
    if (canSwapTile(number)) {
      setState(() {
        final indexOfTile = tileNumbers.indexOf(number);
        final indexOfEmpty = tileNumbers.indexOf(0);
        tileNumbers[indexOfTile] = 0;
        tileNumbers[indexOfEmpty] = number;
      });
    }
  }

  // タップしたタイルが空白と入れ替え可能であるか
  bool canSwapTile(int number) {
    final indexOfTile = tileNumbers.indexOf(number);
    final indexOfEmpty = tileNumbers.indexOf(0);
    switch (indexOfEmpty) {
      case 0:
        return [1, 3].contains(indexOfTile);
      case 1:
        return [0, 2, 4].contains(indexOfTile);
      case 2:
        return [1, 5].contains(indexOfTile);
      case 3:
        return [0, 4, 6].contains(indexOfTile);
      case 4:
        return [1, 3, 5, 7].contains(indexOfTile);
      case 5:
        return [2, 4, 8].contains(indexOfTile);
      case 6:
        return [3, 7].contains(indexOfTile);
      case 7:
        return [4, 6, 8].contains(indexOfTile);
      case 8:
        return [5, 7].contains(indexOfTile);
      default:
        return false;
    }
  }

  // タイルをシャッフルする
  void shuffleTiles() {
    setState(() {
      tileNumbers.shuffle();
    });
  }

  // 現在のタイルの状態を保存する
  void saveTileNumbers() async {
    final value = jsonEncode(tileNumbers);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('TILE_NUMBERS', value);
  }

  // 保存したタイルの状態を読み込む
  void loadTileNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('TILE_NUMBERS');
    if (value != null) {
      final numbers =
          (jsonDecode(value) as List<dynamic>).map((v) => v as int).toList();
      setState(() {
        tileNumbers = numbers;
      });
    }
  }
}

class TilesView extends StatelessWidget {
  final List<int> numbers;
  final bool isCorrect;
  final void Function(int number) onPressed;

  const TilesView({
    Key? key,
    required this.numbers,
    required this.isCorrect,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // グリッド状にWidgetを並べる
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: numbers // 受け取ったデータを元に表示する
          .map((number) {
        if (number == 0) {
          return Container();
        }
        return TileView(
          number: number,
          correct: isCorrect,
          color: isCorrect ? Color.fromARGB(255, 255, 235, 56) : Colors.grey,
          onPressed: () => onPressed(number),
        );
      }).toList(),
    );
  }
}

class TileView extends StatelessWidget {
  final int number;
  final Color color;
  final bool correct;
  final void Function() onPressed;

  const TileView(
      {Key? key,
      required this.number,
      required this.color,
      required this.onPressed,
      required this.correct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        textStyle: TextStyle(fontSize: 32),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(color: correct ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
