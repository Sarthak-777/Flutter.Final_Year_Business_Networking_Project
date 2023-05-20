import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/business/create_job_conrtoller.dart';
import 'package:final_project_workconnect/controller/skills_controller.dart';
import 'package:final_project_workconnect/functions/getUsername.dart';
import 'package:final_project_workconnect/view/widgets/dividerWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project_workconnect/view/widgets/TextInputWidget.dart';
import 'package:get/get.dart';

class BusinessJobScreen extends StatefulWidget {
  const BusinessJobScreen({super.key});

  @override
  State<BusinessJobScreen> createState() => _BusinessJobScreenState();
}

class _BusinessJobScreenState extends State<BusinessJobScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _aboutController = TextEditingController();

  final TextEditingController _responsibilityController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();

  SkillController skillController = Get.put(SkillController());
  CreateJobController controller = Get.put(CreateJobController());
  AuthController authController = Get.put(AuthController());

  bool isLoading = false;

  late String val = jobTime[0];
  late String type = jobType[0];

  @override
  Widget build(BuildContext context) {
    // print(skillController.userSkills);
    print(authController.userData['orgName']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Job "),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.addJobsToDB(
            _titleController.text,
            _aboutController.text,
            _responsibilityController.text,
            _experienceController.text,
            val,
            type,
            skillController.userSkills,
            authController.userData['orgName'],
            authController.userData['uid'],
          );
          Get.snackbar("Success", "Job Added");
        },
        label: Text("Complete"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextInputWidget(
                  myIcon: Icons.title,
                  myLabelText: "Job Title",
                  controller: _titleController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _aboutController,
                decoration: const InputDecoration(
                    hintText: 'Enter your description',
                    contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurpleAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _responsibilityController,
                decoration: const InputDecoration(
                    hintText: 'Enter the developers responsibility',
                    contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurpleAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _experienceController,
                decoration: const InputDecoration(
                    hintText: 'Enter the developers experience',
                    contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurpleAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Job Time',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              Row(
                children: [
                  const Icon(Icons.work_history_outlined),
                  const SizedBox(width: 15),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButton(
                        value: val,
                        items: jobTime
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
              Text('Job Type',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              Row(
                children: [
                  const Icon(Icons.work_history_outlined),
                  const SizedBox(width: 15),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButton(
                        value: type,
                        items: jobType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            type = value!;
                          });
                        },
                      )),
                ],
              ),
              Text(
                'Select Skills',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  TextInputWidget(
                    controller: _skillController,
                    myIcon: Icons.search_outlined,
                    myLabelText: "Search for Skill",
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      isLoading = true;
                      List data =
                          await skillController.apicall(_skillController.text);
                      skillController.setSkillData();
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Search',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Obx(() => skillController.skillData.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (int i = 0;
                                    i < skillController.skillData.length;
                                    i++) ...[
                                  InkWell(
                                    onTap: () {
                                      skillController.addSkillsData(
                                          skillController.skillData[i]);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.red[600],
                                        padding: EdgeInsets.all(10),
                                        child:
                                            Text(skillController.skillData[i],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        )
                      : SizedBox()),
                  DividerWidget(text: 'AND'),
                  Obx(() => skillController.userSkills.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (int i = 0;
                                    i < skillController.userSkills.length;
                                    i++) ...[
                                  InkWell(
                                    onTap: () {
                                      skillController.removeSkillFromList(i);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.blue[600],
                                        padding: EdgeInsets.all(10),
                                        child:
                                            Text(skillController.userSkills[i],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        )
                      : isLoading == true
                          ? CircularProgressIndicator()
                          : SizedBox()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
