import '../../core/controllers/theme_controller.dart';
import '../../core/reusable_widgets/check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';


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
  final TextEditingController _usernameController = TextEditingController(text: "Kadir");

  final _formKey = GlobalKey<FormState>();

  final double _min = 10;
  final double _max = 60;

  int _gameEndTime = 10;

  bool _lowLevel = true;
  bool _mediumLevel = false;
  bool _hardLevel = false;

  int _targetMovementSpeed = 750;

  bool _isDark = false;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final themeStorage = GetStorage();
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (themeValue) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            actions: [
              IconButton(
                icon: Icon(themeStorage.read("theme") ? Icons.lightbulb : Icons.lightbulb_outline),
                onPressed: () async {
                  _isDark = await themeStorage.read("theme");
                  themeValue.saveTheme(!_isDark);
                  Get.changeTheme(themeStorage.read("theme") ? ThemeData.dark() : ThemeData.light());
                },
              ),
            ],
            centerTitle: true,
            title: const LabelText(
              text: 'Aim Game'
            ),
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userNameTextFormField,
                        SizedBox(height: 20,),
                        const LabelText(text: 'Game end time (second)'),
                        slider,
                        const LabelText(text: 'Game Level'),
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
                        startGameButton,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get userNameTextFormField => MyTextFormField(
        label: 'Username',
        fontWeight: FontWeight.bold,
        prefixIcon: Icon(Icons.star),
        validationFunction: checkString,
        controller: _usernameController,
      );

  Widget get slider => Slider(
        min: _min,   
        value: _gameEndTime.toDouble(),
        onChanged: (value) => setState(() => _gameEndTime = value.toInt()),
        activeColor: Colors.red,
        label: _gameEndTime.floor().toString(),
        max: _max,
        divisions: 5,
        inactiveColor: Colors.white,
        mouseCursor: MouseCursor.defer,
        onChangeStart: (value) => setState(() => _gameEndTime = value.toInt()),
        onChangeEnd: (value) => setState(() => _gameEndTime = value.toInt()),
      );

  Widget get lowCheckBox => DefaultCheckBox(
        value: _lowLevel,
        onChanged: (value) {
          setState(() {
            if (!_lowLevel && _mediumLevel || _hardLevel) {
              _lowLevel = value;
              _mediumLevel = false;
              _hardLevel = false;
              _targetMovementSpeed = 750;
            }
          });
        },
      );

  Widget get mediumCheckBox => DefaultCheckBox(
        value: _mediumLevel,
        onChanged: (value) {
          setState(() {
            if (!_mediumLevel || _lowLevel || _hardLevel) {
              _mediumLevel = value;
              _lowLevel = false;
              _hardLevel = false;
              _targetMovementSpeed = 550;
            }
          });
        },
      );

  Widget get hardLevelCheckBox => DefaultCheckBox(
        value: _hardLevel,
        onChanged: (value) {
          setState(() {
            if (!_hardLevel || _mediumLevel || _lowLevel) {
              _hardLevel = value;
              _mediumLevel = false;
              _lowLevel = false;
              _targetMovementSpeed = 350;
            }
          });
        },
      );

  Widget get startGameButton => DefaultRaisedButton(
        onPressed: () {
          autovalidateMode = AutovalidateMode.always;
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if ((_lowLevel || _mediumLevel || _hardLevel) && _usernameController.text.length > 0) {
              Get.off(GamePage(
                  userName: _usernameController.text,
                  gameEndTime: _gameEndTime,
                  targetMovementSpeed: _targetMovementSpeed,
              ),);
            }
          } else {
            _showSnackBar();
          }
          setState((){});
        },
        label: 'Start',
      );

  _showSnackBar(){
    Get.snackbar("Error", "Please fill all fields",
      duration: const Duration(seconds: 2),
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(Icons.error,color: Colors.red,size: 25,),
      isDismissible: true,
      margin: const EdgeInsets.all(12),
      maxWidth: double.infinity
    );
  }
}
