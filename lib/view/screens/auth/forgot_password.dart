import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextInputWidget(
              controller: _emailController,
              myIcon: Icons.email_outlined,
              myLabelText: "Email Id",
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: ElevatedButton(
              onPressed: () {
                AuthController().sendPasswordResetEmail(_emailController.text);
                Get.back(result: true);
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'Send Request',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
