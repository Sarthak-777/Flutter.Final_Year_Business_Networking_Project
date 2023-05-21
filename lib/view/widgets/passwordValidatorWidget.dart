import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class TextInputValidatorWidget extends StatelessWidget {
  final TextEditingController controller;
  IconData myIcon;
  String myLabelText;
  bool isObscure;

  TextInputValidatorWidget(
      {Key? key,
      required this.controller,
      required this.myIcon,
      required this.myLabelText,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: Validators.compose([
        Validators.required('Password is required'),
        Validators.patternString(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
            'Invalid Password')
      ]),
    );
  }
}
