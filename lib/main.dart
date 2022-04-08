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
      title: 'Flutter Demo',
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
  var _lines = List<Line>.empty();

  int _startRow = -3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
        ),
        body: RenderBoard());
  }

  Widget RenderBoard() {
    final children = <Widget>[];
    for (var i = 0; i < 4; i++) {
      children.add(RenderRow());
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget RenderRow() {
    setState(() {
      _startRow += 3;
    });

    final children = <Widget>[];
    for (var j = _startRow; j < _startRow + 3; j++) {
      children.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if (j == 1 || j == 4 || j == 7 || j == 10)
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 10,
                  color: Colors.white,
                ),
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: _dots.length > j && _dots[j] == 0
                        ? Colors.grey
                        : _dots.length > j && _dots[j] == 1
                            ? Colors.blueAccent
                            : Colors.redAccent),
              ),
              if (j == 1 || j == 4 || j == 7 || j == 10)
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 10,
                  color: Colors.white,
                )
            ],
          ),
          if (j < 9)
            Container(
              width: 10,
              height: MediaQuery.of(context).size.width / 4,
              color: Colors.white,
            ),
        ],
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}

class Line {
  int source = 0;
  int destination = 0;
}
