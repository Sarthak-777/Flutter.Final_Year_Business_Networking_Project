import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/screens/auth/forgot_password.dart';
import 'package:final_project_workconnect/view/screens/business/auth/business_login_screen.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:final_project_workconnect/view/widgets/dividerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
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
                    'Login',
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
                      AuthController().loginWithEmalAndPassword(
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 60.0),
                  child: InkWell(
                    onTap: () {
                      AuthController().googleSignIn();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google-icon.png',
                              height: 25,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Log In with Google',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text('New to WorkConnect? '),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    child: const Text('Register',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => BusinessLoginScreen());
                    },
                    child: const Text('Are you a Employer?',
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
