import 'package:flutter/material.dart';

/*TextForm fieldin kullanılacağı yerlerde base sınıf olarak yazıldı*/
class MyTextFormField extends StatelessWidget {
  final String label;
  final TextStyle textStyle;
  final TextEditingController controller;
  final bool password;
  final int characterLenght;
  final FontWeight fontWeight;
  final IconButton trailingIcon;
  final FocusNode focusNode;
  final bool autoFocus;
  final bool autoValidate;
  final Function onTap;
  final String labelText;
  final Icon prefixIcon;
  final Color labelColor;
  final Function validationFunction;

  MyTextFormField(
      {Key key,
      this.label,
      this.focusNode,
      this.trailingIcon,
      this.textStyle,
      this.fontWeight,
      this.password,
      this.controller,
      this.characterLenght,
      this.autoFocus,
      this.autoValidate,
      this.onTap,
      this.labelText,
      this.prefixIcon,
      this.labelColor, this.validationFunction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: this.onTap,
      autofocus: this.autoFocus ?? false,
      focusNode: this.focusNode,
      obscureText: this.password ?? false,
      maxLength: this.characterLenght,
      controller: this.controller,
      validator: this.validationFunction,
      style: this.textStyle,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 15.5,
        ),
        suffixIcon: this.trailingIcon,
        hintText: this.label,
        labelText: this.labelText,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        prefixIcon: this.prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.001)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
      ),
    );
  }
}
