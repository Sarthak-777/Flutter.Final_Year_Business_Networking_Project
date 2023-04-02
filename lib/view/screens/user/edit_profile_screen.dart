import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/customize_profile_controller.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userDescriptionController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  CustomizeProfileController controller = Get.put(CustomizeProfileController());
  late String val = working[0];
  late String jobCategory = category[0];
  late String theme = themeData[0];

  @override
  Widget build(BuildContext context) {
    print(theme);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text("Customise Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            TextInputWidget(
              controller: userDescriptionController,
              myIcon: Icons.person,
              myLabelText: "Add your description",
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Preferred Job Category ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: iconBool ? Colors.grey[200] : Colors.black)),
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
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Change Profile Theme',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    const Icon(Icons.work_outlined),
                    const SizedBox(width: 15),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton(
                          value: theme,
                          items: themeData
                              .map<DropdownMenuItem<String>>((var obj) {
                            return DropdownMenuItem(
                              value: obj,
                              child: Text(obj),
                            );
                          }).toList(),
                          onChanged: (String? data) {
                            setState(() {
                              theme = data!;
                            });
                          },
                        )),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.customizeDataFireabase(
                      userDescriptionController.text, jobCategory, theme);
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
