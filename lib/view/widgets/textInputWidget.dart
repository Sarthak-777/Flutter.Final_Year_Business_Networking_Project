import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  IconData myIcon;
  String myLabelText;
  bool isObscure;

  TextInputWidget(
      {Key? key,
      required this.controller,
      required this.myIcon,
      required this.myLabelText,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        labelText: myLabelText,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
