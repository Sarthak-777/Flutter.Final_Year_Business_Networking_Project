import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/business/business_customize_profile_controller.dart';
import 'package:final_project_workconnect/controller/customize_profile_controller.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBusinessProfileScreen extends StatefulWidget {
  EditBusinessProfileScreen({super.key});

  @override
  State<EditBusinessProfileScreen> createState() =>
      _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState extends State<EditBusinessProfileScreen> {
  TextEditingController businessDescriptionController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  CustomizeBusinessProfileController controller =
      Get.put(CustomizeBusinessProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text("Customise your Business Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            TextInputWidget(
              controller: businessDescriptionController,
              myIcon: Icons.business,
              myLabelText: "Add your description",
            ),
            SizedBox(height: 20),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.customizeDataFireabase(
                      businessDescriptionController.text);
                  Get.back();
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
