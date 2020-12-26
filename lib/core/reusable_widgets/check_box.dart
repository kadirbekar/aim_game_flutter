import 'package:flutter/material.dart';

class DefaultCheckBox extends StatefulWidget {
  final Function onChanged;
  final bool value;

  DefaultCheckBox({Key key, this.onChanged, this.value}) : super(key: key);

  @override
  _DefaultCheckBoxState createState() => _DefaultCheckBoxState();
}

class _DefaultCheckBoxState extends State<DefaultCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.teal,
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
