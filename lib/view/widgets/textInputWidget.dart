import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  IconData myIcon;
  String myLabelText;

  TextInputWidget({Key? key, required this.myIcon, required this.myLabelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
