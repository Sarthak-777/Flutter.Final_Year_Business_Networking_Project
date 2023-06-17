import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddExperienceScreen extends StatefulWidget {
  String? uid;
  AddExperienceScreen({super.key, required this.uid});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  TextEditingController jobNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  late String current = currentJob[0];
  late String startYear = Date[10];
  late String endYear = Date[12];

  @override
  Widget build(BuildContext context) {
    print(widget.uid);
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
              controller: jobNameController,
              myIcon: Icons.person,
              myLabelText: "Add your Business Name",
            ),
            SizedBox(height: 20),
            TextInputWidget(
              controller: positionController,
              myIcon: Icons.boy_sharp,
              myLabelText: "Add your Job Position",
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add your start date',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )),
                Row(
                  children: [
                    const Icon(Icons.punch_clock),
                    const SizedBox(width: 15),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton(
                          value: startYear,
                          items: Date.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              startYear = value!;
                            });
                          },
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add your end date',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )),
                Row(
                  children: [
                    const Icon(Icons.lock_clock),
                    const SizedBox(width: 15),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton(
                          value: endYear,
                          items: Date.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              endYear = value!;
                            });
                          },
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Is this your current Job ?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )),
                Row(
                  children: [
                    const Icon(Icons.work_outlined),
                    const SizedBox(width: 15),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton(
                          value: current,
                          items: currentJob
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              current = value!;
                            });
                          },
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    if (jobNameController.text.isNotEmpty &&
                        positionController.text.isNotEmpty &&
                        startYear.isNotEmpty &&
                        endYear.isNotEmpty &&
                        current.isNotEmpty) {
                      if (int.parse(endYear) < int.parse(startYear)) {
                        Get.snackbar("Error", "Please enter correct data");
                      } else {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.uid)
                            .update(
                          {
                            'experience': FieldValue.arrayUnion([
                              {
                                'jobName': jobNameController.text,
                                'position': positionController.text,
                                'startYear': startYear,
                                'endYear': endYear,
                                'current': current
                              }
                            ]),
                          },
                        );
                        Get.back();
                        Get.snackbar("success", "Job Add Success");
                      }
                    } else {
                      Get.snackbar("Error", "Please enter all the fields");
                    }
                  } catch (e) {
                    Get.snackbar("Error", e.toString());
                  }
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
