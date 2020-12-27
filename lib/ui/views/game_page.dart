import 'dart:async';
import 'dart:math';

import '../../core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  double width = 96;
  double height = 96;
  Color color = Colors.green;
  BorderRadius borderRadius = BorderRadius.circular(8);
  List<AlignmentGeometry> positions;
  Alignment alignment;
  Random random;
  int point = 0;
  Timer timer;
  bool startAnimationButtonVisible = true;
  final randomInt = 256;
  int endTime;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    random = Random();
    initializePositions();
    alignment = positions[6];
    endTime = widget.gameEndTime;

    _animationController = AnimationController(
        duration: Duration(
          milliseconds: widget.targetMovementSpeed,
        ),
        vsync: this);

    _animation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut
      ),
    )
      ..addListener(() {
        setState(() {
          
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
          alignment = positions[random.nextInt(9).toInt()];
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
          alignment = positions[random.nextInt(9).toInt()];
        }
      });
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
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick != widget.gameEndTime) {
        setState(() {
          endTime--;
          width = 80;
          height = 80;

          color = Color.fromRGBO(
            random.nextInt(randomInt),
            random.nextInt(randomInt),
            random.nextInt(randomInt),
            1,
          );

          borderRadius = BorderRadius.circular(random.nextInt(12).toDouble());
        });
      } else {
        timer.cancel();
        _showResultDialog();
        _animationController.stop();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.teal,
            title: LabelText(
              text: widget.userName,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     LabelText(text: "Total Point : $point"),
                     LabelText(text: "Game end time : $endTime"),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!startAnimationButtonVisible) stopAnimation,
              const SizedBox(height: 15),
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
          _animationController.stop();
        },
        label: const LabelText(text: 'Stop'),
      );

  Widget get startGame => FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        heroTag: 'start',
        onPressed: () {
            startAnimation();
            startAnimationButtonVisible = false;
            _animationController.forward();
        },
        label: const LabelText(
          text: 'Start',
        ),
        icon: const Icon(Icons.play_circle_filled),
      );

  Widget get aimGameBox => Transform.rotate(
    angle: _animation.value,
      child: AnimatedContainer(
    child: Image.asset(
      ImageConstants.TARGET,
      fit: BoxFit.cover,
    ),
    width: width,
    padding: const EdgeInsets.all(6),
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: borderRadius,
    ),
    duration: Duration(milliseconds: widget.targetMovementSpeed),
    curve: Curves.easeIn,
      ),
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
