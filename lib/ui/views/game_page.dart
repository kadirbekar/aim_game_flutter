import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/reusable_widgets/alert_dialog.dart';
import '../../core/reusable_widgets/label_text.dart';

class GamePage extends StatefulWidget {
  final String userName;
  final int aimBoxDuration;
  final int gameLevelDuration;
  GamePage({
    Key key,
    this.userName,
    this.aimBoxDuration,
    this.gameLevelDuration,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  double width = 50;
  double height = 50;
  Color color = Colors.green;
  BorderRadius borderRadius = BorderRadius.circular(8);
  double fontSize = 16.0;
  Color fontColor = Colors.red;
  List<AlignmentGeometry> positions;
  Alignment alignment;
  var random;
  int point = 0;
  bool isStarted = false;
  Timer timer;
  bool startAnimationButtonVisible = true;

  @override
  void initState() {
    super.initState();
    random = Random();
    initializePositions();
    alignment = positions[6];
  }

  //set aim box positions
  initializePositions() {
    positions = [
      Alignment.bottomCenter,
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.topCenter,
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight,
    ];
  }

  //start animation
  //Duration, animasyonun oynatma hızını belirliyor.
  startAnimation() {
    timer = Timer.periodic(Duration(milliseconds: widget.gameLevelDuration),
        (timer) {
      setState(() {
        alignment = positions[random.nextInt(6).toInt()];

        width = random.nextInt(300).toDouble();
        height = random.nextInt(300).toDouble();

        color = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1,
        );

        borderRadius = BorderRadius.circular(random.nextInt(25).toDouble());

        fontSize = random.nextInt(30).toDouble();

        fontColor = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1,
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("sayfa tekrar build edildi");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

        print("test");
      },
      child: Scaffold(
        appBar: AppBar(
          title: LabelText(
            text: widget.userName,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Row(
                children: [
                  const LabelText(text: "Total Point : "),
                  LabelText(
                    text: "$point",
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            stopAnimation,
            const SizedBox(
              height: 15,
            ),
            if (startAnimationButtonVisible) startGame,
          ],
        ),
        body: Stack(
          alignment: alignment,
          children: [
            Positioned(
              height: height,
              width: width,
              child: GestureDetector(
                onTap: () {
                  if (!startAnimationButtonVisible)
                    setState(
                      () {
                        point++;

                        print("CURRENT POINT : " + point.toString());
                      },
                    );
                },
                child: aimGameBox,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get appbar => AppBar(
          title: LabelText(
        text: "Aim Game",
      ));

  Widget get aimBoxText => Container(
        child: Image.asset(
          "assets/images/target.png",
          fit: BoxFit.cover,
        ),
      );

  Widget get stopAnimation => FloatingActionButton.extended(
        heroTag: 'stop',
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.stop,
          color: Colors.white,
        ),
        onPressed: () {
          timer.cancel();
          ShowCustomDialogBox.showAlertDialogWithAction(
            context: context,
            title: 'Game Over',
            content: 'Your point is : $point',
            rightButtonOnPressed: () {},
          );
        },
        label: const LabelText(
          text: 'Stop',
        ),
      );

  Widget get startGame => FloatingActionButton.extended(
        heroTag: 'start',
        onPressed: () {
          setState(() {
            startAnimation();
            startAnimationButtonVisible = false;
          });
        },
        label: const LabelText(
          text: 'Start',
        ),
        icon: Icon(Icons.play_circle_filled),
      );

  Widget get aimGameBox => AnimatedContainer(
        child: aimBoxText,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        duration: Duration(
          milliseconds: widget.aimBoxDuration,
        ),
        curve: Curves.easeIn,
      );
}
