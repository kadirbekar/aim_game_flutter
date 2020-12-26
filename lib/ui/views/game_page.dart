import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/image_constants.dart';
import '../../core/reusable_widgets/alert_dialog.dart';
import '../../core/reusable_widgets/label_text.dart';
import 'home_page.dart';

class GamePage extends StatefulWidget {
  final String userName;
  final int gameEndTime;
  final int targetMovementSpeed;
  GamePage({
    Key key,
    this.userName,
    this.gameEndTime,
    this.targetMovementSpeed,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double width = 96;
  double height = 96;
  Color color = Colors.green;
  BorderRadius borderRadius = BorderRadius.circular(8);
  double fontSize = 16.0;
  Color fontColor = Colors.red;
  List<AlignmentGeometry> positions;
  Alignment alignment;
  Random random;
  int point = 0;
  Timer timer;
  Timer changeTargetPosition;
  bool startAnimationButtonVisible = true;
  final randomInt = 256;
  int endTime;

  @override
  void initState() {
    super.initState();
    random = Random();
    initializePositions();
    alignment = positions[6];
    endTime = widget.gameEndTime;
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

  startAnimation() {
    timer = Timer.periodic(Duration(milliseconds: widget.targetMovementSpeed),(timer) {
      if (timer.tick != widget.gameEndTime) {
        setState(() {
          endTime--;

          alignment = positions[random.nextInt(6).toInt()];

          width = random.nextInt(300).toDouble();
          height = random.nextInt(300).toDouble();

          color = Color.fromRGBO(
            random.nextInt(randomInt),
            random.nextInt(randomInt),
            random.nextInt(randomInt),
            1,
          );

          borderRadius = BorderRadius.circular(random.nextInt(25).toDouble());

          fontSize = random.nextInt(30).toDouble();

          fontColor = Color.fromRGBO(
            random.nextInt(randomInt),
            random.nextInt(randomInt),
            random.nextInt(randomInt),
            1,
          );
        });
      } else {
        _showResultDialog();
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: LabelText(
              text: widget.userName,
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelText(text: "Total Point : $point"),
                    LabelText(
                      text: "Game end time : $endTime",
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!startAnimationButtonVisible) stopAnimation,
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
                    if (!startAnimationButtonVisible) setState(() => point++);
                  },
                  child: aimGameBox,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get appbar => AppBar(
        title: const LabelText(
          text: "Aim Game",
        ),
      );

  Widget get aimBoxText => Container(
        child: Image.asset(
          ImageConstants.TARGET,
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
          _showResultDialog();
        },
        label: const LabelText(text: 'Stop'),
      );

  Widget get startGame => FloatingActionButton.extended(
        heroTag: 'start',
        onPressed: () {
          startAnimation();
          startAnimationButtonVisible = false;
        },
        label: const LabelText(
          text: 'Start',
        ),
        icon: const Icon(Icons.play_circle_filled),
      );

  Widget get aimGameBox => AnimatedContainer(
        child: aimBoxText,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        duration: Duration(seconds: widget.targetMovementSpeed),
        curve: Curves.easeIn,
      );

  _showResultDialog() {
    ShowCustomDialogBox.showAlertDialogWithAction(
      context: context,
      title: 'Game Over',
      content: 'Your point is : $point',
      rightButtonOnPressed: () => Get.offAll(HomePage()),
    );
  }
}
