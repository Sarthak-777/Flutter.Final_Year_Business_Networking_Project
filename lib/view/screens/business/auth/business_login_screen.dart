import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/screens/auth/forgot_password.dart';
import 'package:final_project_workconnect/view/screens/business/auth/business_register_screen.dart';
import 'package:final_project_workconnect/view/widgets/dividerWidget.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessLoginScreen extends StatelessWidget {
  BusinessLoginScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset(
                    'assets/login-splash.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Login as Employer',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextInputWidget(
                    controller: _emailController,
                    myIcon: Icons.email_outlined,
                    myLabelText: "Email Id",
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextInputWidget(
                    controller: _passwordController,
                    myIcon: Icons.lock_outline,
                    isObscure: true,
                    myLabelText: "password",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    bool result = await Get.to(() => ForgotPassword());
                    print(result);
                    if (result != null && result == true) {
                      //Show SnackBar
                      Get.snackbar("Email sent",
                          "An email has been sent to reset password");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    width: double.infinity,
                    child: const Text(
                      'Forgot Password ? ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: ElevatedButton(
                    onPressed: () {
                      AuthController().businessLoginWithEmailAndPassword(
                          _emailController.text, _passwordController.text);
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DividerWidget(),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => BusinessRegisterScreen());
                    },
                    child: const Text('Sign up as Employer',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700)),
                  ),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text('Login as Employee '),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: const Text('Login',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700)),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
