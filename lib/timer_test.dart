import 'dart:async';

import 'package:flutter/material.dart';

class TimerTestPage extends StatefulWidget {
  TimerTestPage({Key key}) : super(key: key);

  @override
  _TimerTestPageState createState() => _TimerTestPageState();
}

class _TimerTestPageState extends State<TimerTestPage> {
  int counter = 0;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    print("Build metodu tetiklendi");
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 100,
        width: 100,
        child: FloatingActionButton(
          isExtended: true,
          backgroundColor: Colors.red,
          onPressed: () {
            timer = Timer.periodic(Duration(seconds: 1), (counterTimer) {
              if (counterTimer.tick <= 20) {
                print("Sayac ${counterTimer.tick}");
                setState(() {
                  counter++;
                });
              }
            });
          },
          child: Text(
            "Start Timer",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Center(
          child: Text(
        counter.toString(),
        style: TextStyle(
          fontSize: 35,
          color: Colors.red,
        ),
      )),
    );
  }
}
