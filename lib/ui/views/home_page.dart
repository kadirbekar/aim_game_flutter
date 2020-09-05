import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/extensions/context_extension.dart';
import '../../core/mixin/form_validation.dart';
import '../../core/reusable_widgets/label_text.dart';
import '../../core/reusable_widgets/raised_button.dart';
import '../../core/reusable_widgets/text_form_field.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with FormValidation {
  final TextEditingController _controller =
      TextEditingController(text: 'Kadir');

  final _formKey = GlobalKey<FormState>();

  double sliderValue = 12.0;

  final double maxGameFastRange = 50;

  final int divisionOfSlider = 49;
  int durationValue = 1200;

  int time;

  bool lowLevel = true;
  bool mediumLevel = false;
  bool hardLevel = false;

  int gameLevelDuration = 1050;

  bool autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: appbar,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: context.paddingLow,
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  autovalidate: autoValidate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userNameTextFormField,
                      SizedBox(height: context.mediumValue,),
                      const LabelText(text: 'Pick up a number',),
                      SizedBox(height: context.mediumValue,),
                      slider,
                      SizedBox(height: context.mediumValue,),
                      const LabelText(text: 'Game Level',),
                      SizedBox(height: context.mediumValue,),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const LabelText(
                              text: 'Low',
                            ),
                            lowCheckBox,
                            const LabelText(
                              text: 'Medium',
                            ),
                            mediumCheckBox,
                            const LabelText(
                              text: 'Hard',
                            ),
                            hardLevelCheckBox,
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      startGameButton,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get appbar => AppBar(
        centerTitle: true,
        title: const LabelText(
          text: 'Aim Game',
        ),
      );

  Widget get userNameTextFormField => MyTextFormField(
        label: 'Username',
        fontWeight: FontWeight.bold,
        prefixIcon: Icon(Icons.account_circle),
        validationFunction: checkString,
        lineCount: 1,
        controller: _controller,
      );

  Widget get slider => Slider(
        value: sliderValue,
        onChanged: (value) {
          setState(() {
            sliderValue = value;
          });
        },
        activeColor: Colors.red,
        label: sliderValue.floor().toString(),
        max: maxGameFastRange,
        divisions: divisionOfSlider,
        inactiveColor: Colors.white,
        mouseCursor: MouseCursor.defer,
        onChangeStart: (value) {
          setState(() {
            sliderValue = value;
            durationValue = sliderValue.toInt();
            print("Duration value " + durationValue.toString().split(".")[0]);
            durationValue *= 100;
            print(durationValue);
          });
        },
        onChangeEnd: (value) {
          setState(() {
            sliderValue = value;
          });
        },
      );

  Widget get lowCheckBox => Checkbox(
        value: lowLevel,
        onChanged: (value) {
          setState(() {
            if (!lowLevel && mediumLevel || hardLevel) {
              lowLevel = value;
              mediumLevel = false;
              hardLevel = false;
              gameLevelDuration = 840;
            }
          });
        },
      );

  Widget get mediumCheckBox => Checkbox(
        value: mediumLevel,
        onChanged: (value) {
          setState(() {
            if (!mediumLevel || lowLevel || hardLevel) {
              mediumLevel = value;
              lowLevel = false;
              hardLevel = false;
              gameLevelDuration = 560;
            }
          });
        },
      );

  Widget get hardLevelCheckBox => Checkbox(
        value: hardLevel,
        onChanged: (value) {
          setState(() {
            if (!hardLevel || mediumLevel || lowLevel) {
              hardLevel = value;
              mediumLevel = false;
              lowLevel = false;
              gameLevelDuration = 280;
            }
          });
        },
      );

  Widget get startGameButton => DefaultRaisedButton(
        onPressed: () {
          autoValidate = true;
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if (lowLevel ||
                mediumLevel ||
                hardLevel &&
                    durationValue != null &&
                    gameLevelDuration != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    userName: _controller.text,
                    aimBoxDuration: durationValue,
                    gameLevelDuration: gameLevelDuration,
                  ),
                ),
              );
            }
          }
        },
        label: 'Start',
      );
}
