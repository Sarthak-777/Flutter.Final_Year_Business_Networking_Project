import 'package:final_project_workconnect/controller/skills_controller.dart';
import 'package:final_project_workconnect/functions/skillsApi.dart';
import 'package:final_project_workconnect/view/widgets/dividerWidget.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class SkillsScreen extends StatefulWidget {
  SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final TextEditingController _skillController = TextEditingController();

  SkillController skillController = Get.put(SkillController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Skills",
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            skillController.storeSkillsToFirestore(skillController.userSkills,
                FirebaseAuth.instance.currentUser!.uid);
          },
          label: Text("Complete")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                                  child: Text(skillController.skillData[i],
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
                                  child: Text(skillController.userSkills[i],
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
      ),
    );
  }
}
