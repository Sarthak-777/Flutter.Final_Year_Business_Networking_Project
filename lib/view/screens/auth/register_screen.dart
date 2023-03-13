import 'dart:ffi';

import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/widgets/TextInputWidget.dart';
import 'package:final_project_workconnect/view/widgets/dividerWidget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  // TextEditingController _phoneController = TextEditingController();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    log('register');

    return Scaffold(
      body: SingleChildScrollView(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
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
              Flexible(
                child: SizedBox(
                  child: Stepper(
                    steps: getSteps(),
                    type: StepperType.horizontal,
                    currentStep: currentStep,
                    onStepContinue: () {
                      final isLastStep = currentStep == getSteps().length - 1;
                      if (isLastStep) {
                        AuthController().signUp(
                            _emailController.text,
                            _usernameController.text,
                            _passwordController.text,
                            _countryNameController.text,
                            _cityNameController.text,
                            _phoneController.text,
                            val,
                            jobCategory);
                        log('complete');
                        // Get.toNamed('/login');
                      } else {
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    },
                    onStepCancel: currentStep == 0
                        ? null
                        : () => setState(() {
                              currentStep -= 1;
                            }),
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3.0, vertical: 15),
                  child: Text('Already using WorkConnect? '),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/login');
                  },
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

  late String val = working[0];
  late String jobCategory = category[0];

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text("Account"),
          content: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextInputWidget(
                  myIcon: Icons.email_outlined,
                  myLabelText: "Email Id",
                  controller: _emailController,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextInputWidget(
                    myIcon: Icons.person_outline,
                    myLabelText: "Username",
                    controller: _usernameController),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextInputWidget(
                  myIcon: Icons.lock_outline,
                  isObscure: true,
                  myLabelText: "password",
                  controller: _passwordController,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text("Address"),
          content: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextInputWidget(
                  myIcon: Icons.location_on_outlined,
                  myLabelText: "Country",
                  controller: _countryNameController,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextInputWidget(
                  myIcon: Icons.location_city_outlined,
                  myLabelText: "City",
                  controller: _cityNameController,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextInputWidget(
                  myIcon: Icons.phone_android_outlined,
                  myLabelText: "Phone Number",
                  controller: _phoneController,
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text("Complete"),
          content: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Are you working ? ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  Row(
                    children: [
                      const Icon(Icons.work_history_outlined),
                      const SizedBox(width: 15),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButton(
                            value: val,
                            items: working
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                val = value!;
                              });
                            },
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preferred Job Category ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  Row(
                    children: [
                      const Icon(Icons.work_outlined),
                      const SizedBox(width: 15),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButton(
                            value: jobCategory,
                            items: category
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                jobCategory = value!;
                              });
                            },
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ];
}
