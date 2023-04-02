import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessRegisterScreen extends StatefulWidget {
  const BusinessRegisterScreen({super.key});

  @override
  State<BusinessRegisterScreen> createState() => _BusinessRegisterScreenState();
}

late String val = JobIndustry[0];
final TextEditingController _organisationController = TextEditingController();
final TextEditingController _contactController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

AuthController authController = Get.put(AuthController());

class _BusinessRegisterScreenState extends State<BusinessRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up as a Employer"),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferred Job Category ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work_history_outlined),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton(
                          value: val,
                          items: JobIndustry.map<DropdownMenuItem<String>>(
                              (String value) {
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
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextInputWidget(
                      myIcon: Icons.business,
                      myLabelText: "Organisation Name",
                      controller: _organisationController,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextInputWidget(
                        myIcon: Icons.contact_phone_outlined,
                        myLabelText: "Organisation Contact Number",
                        controller: _contactController),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextInputWidget(
                        myIcon: Icons.email_outlined,
                        myLabelText: "Organisation email",
                        controller: _emailController),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextInputWidget(
                      myIcon: Icons.lock_outline,
                      isObscure: true,
                      myLabelText: "Password",
                      controller: _passwordController,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blueGrey.shade900),
                      ),
                      onPressed: () {
                        authController.businessSignUp(
                          val,
                          _organisationController.text,
                          _contactController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                        // AuthController().loginWithEmalAndPassword(
                        //     _emailController.text, _passwordController.text);
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
