import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleLogin extends StatefulWidget {
  GoogleLogin({Key? key}) : super(key: key);

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  var userData = Get.arguments.first.user;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late String val = working[0];
  late String jobCategory = category[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Additional Information'),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                print(user?.email);

                if (user != null) {
                  try {
                    FirebaseFirestore.instance
                        .collection("email")
                        .doc(user.email)
                        .delete();
                    await user.delete();
                    Get.snackbar("Error", "Google Login Error");
                    FirebaseAuth.instance.signOut();
                    // You can perform additional actions after account deletion if needed.
                  } catch (e) {
                    print(e);
                    // Handle any error that occurs during deletion.
                  }
                } else {
                  print('No user is currently signed in.');
                }
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          })),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 25,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/google-icon.png',
                    height: 80,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Are you working ? ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                    Row(
                      children: [
                        const Icon(Icons.work_history_outlined),
                        const SizedBox(width: 15),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: DropdownButton(
                              value: val,
                              items: working.map<DropdownMenuItem<String>>(
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                    Row(
                      children: [
                        const Icon(Icons.work_outlined),
                        const SizedBox(width: 15),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: DropdownButton(
                              value: jobCategory,
                              items: category.map<DropdownMenuItem<String>>(
                                  (String value) {
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AuthController().googleAdditionalInfoPage(
          userData.uid,
          userData.email,
          _usernameController.text,
          _countryNameController.text,
          _cityNameController.text,
          _phoneController.text,
          val,
          jobCategory,
        ),
        tooltip: 'Increment Counter',
        child: const Text(
          'Submit',
        ),
      ),
    );
  }
}
