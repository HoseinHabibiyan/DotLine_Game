import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dot Line Game',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _dots = List<int>.filled(12, 0);
  var _lines = new List<Line>.empty(growable: true);

  int _startRow = -3;
  bool _firstPlayerRound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Dot Line Game"),
        ),
        body: renderBoard());
  }

  Widget renderBoard() {
    _startRow = -3;
    final children = <Widget>[];
    for (var i = 0; i < 4; i++) {
      children.add(renderRow());
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget renderRow() {
    setState(() {
      _startRow += 3;
    });

    final children = <Widget>[];
    for (var dotIndex = _startRow; dotIndex < _startRow + 3; dotIndex++) {
      children.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if (dotIndex == 1 ||
                  dotIndex == 4 ||
                  dotIndex == 7 ||
                  dotIndex == 10)
                InkWell(
                  onTap: () => {drawHorizontalLine(dotIndex - 1)},
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 10,
                    color: _lines.any((x) =>
                            x.source == dotIndex - 1 &&
                            x.destination == dotIndex)
                        ? _lines
                                    .firstWhere((x) =>
                                        x.source == dotIndex - 1 &&
                                        x.destination == dotIndex)
                                    .player ==
                                0
                            ? Colors.blueAccent
                            : Colors.redAccent
                        : Colors.black,
                  ),
                ),
              Container(
                alignment: Alignment.center,
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: _dots.length > dotIndex && _dots[dotIndex] == 0
                        ? Color.fromARGB(255, 255, 255, 255)
                        : _dots.length > dotIndex && _dots[dotIndex] == 1
                            ? Colors.blueAccent
                            : Colors.redAccent),
              ),
              if (dotIndex == 1 ||
                  dotIndex == 4 ||
                  dotIndex == 7 ||
                  dotIndex == 10)
                InkWell(
                  onTap: () => {drawHorizontalLine(dotIndex)},
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 10,
                    color: _lines.any((x) =>
                            x.source == dotIndex &&
                            x.destination == dotIndex + 1)
                        ? _lines
                                    .firstWhere((x) =>
                                        x.source == dotIndex &&
                                        x.destination == dotIndex + 1)
                                    .player ==
                                0
                            ? Colors.blueAccent
                            : Colors.redAccent
                        : Colors.black,
                  ),
                )
            ],
          ),
          if (dotIndex < 9)
            InkWell(
              onTap: () => {drawVerticalLine(dotIndex)},
              child: Container(
                width: 10,
                height: MediaQuery.of(context).size.width / 4,
                color: _lines.any((x) =>
                        x.source == dotIndex && x.destination == dotIndex + 3)
                    ? _lines
                                .firstWhere((x) =>
                                    x.source == dotIndex &&
                                    x.destination == dotIndex + 3)
                                .player ==
                            0
                        ? Colors.blueAccent
                        : Colors.redAccent
                    : Colors.black,
              ),
            ),
        ],
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  void drawVerticalLine(int dotIndex) {
    if (_lines
        .any((x) => x.source == dotIndex && x.destination == dotIndex + 3)) {
      return;
    }

    _firstPlayerRound = !_firstPlayerRound;

    print("dot ${dotIndex}");
    _lines.add(Line(dotIndex, dotIndex + 3, _firstPlayerRound ? 0 : 1));
    renderBoard();
  }

  void drawHorizontalLine(int dotIndex) {
    if (_lines
        .any((x) => x.source == dotIndex && x.destination == dotIndex + 1)) {
      return;
    }

    _firstPlayerRound = !_firstPlayerRound;

    print("dot ${dotIndex}");
    _lines.add(Line(dotIndex, dotIndex + 1, _firstPlayerRound ? 0 : 1));
    renderBoard();
  }
}

class Line {
  int source, destination, player;
  Line(this.source, this.destination, this.player) {}
}
