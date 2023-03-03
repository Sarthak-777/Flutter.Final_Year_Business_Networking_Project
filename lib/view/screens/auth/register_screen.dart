import 'package:final_project_workconnect/view/widgets/TextInputWidget.dart';
import 'package:final_project_workconnect/view/widgets/dividerWidget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                  'Register',
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
                    myIcon: Icons.email_outlined, myLabelText: "Email Id"),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextInputWidget(
                    myIcon: Icons.person_outline, myLabelText: "Username"),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextInputWidget(
                    myIcon: Icons.phone_android_outlined,
                    myLabelText: "Mobile"),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text('Already using WorkConnect? '),
                ),
                InkWell(
                  onTap: () {},
                  child: Text('Log In',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700)),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
