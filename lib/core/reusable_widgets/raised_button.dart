import 'package:flutter/material.dart';

class DefaultRaisedButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final double leftBorderRadiusValue;
  final double rightBorderRadiusValue;
  final Function onPressed;
  final TextStyle textStyle;
  final Color color;

  DefaultRaisedButton({
    Key key,
    this.label,
    this.height,
    this.width,
    this.leftBorderRadiusValue,
    this.rightBorderRadiusValue,
    this.onPressed,
    this.textStyle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      width: width * 0.60,
      child: RaisedButton(
        color: this.color ?? Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(leftBorderRadiusValue ?? 25),
            topRight: Radius.circular(rightBorderRadiusValue ?? 25),
          ),
        ),
        onPressed: this.onPressed,
        child: Text(
          this.label ?? "unnamed",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
