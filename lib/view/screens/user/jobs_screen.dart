import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/job_controller.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:final_project_workconnect/view/screens/user/job_description_screen.dart';
import 'package:final_project_workconnect/view/widgets/jobSkillWidget.dart';
import 'package:final_project_workconnect/view/widgets/skillsWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  AuthController authController = Get.put(AuthController());
  JobController jobController = Get.put(JobController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data = jobController.getRecommendedSkillData();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    print(authController.userData['skills']);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello ${authController.userData['username']} 👋 ",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Find Jobs',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...");
                        }
                        List skills = (snapshot.data as dynamic)['skills'];

                        return skills.isEmpty
                            ? Container(
                                child: Text(
                                    'Please add Skills in Profile to filter jobs',
                                    style: TextStyle(
                                        color: Colors.grey[200],
                                        fontWeight: FontWeight.w600)),
                              )
                            : SizedBox(
                                height: 40,
                                width: 500,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    jobSkillWidget(
                                      uid: (snapshot.data as dynamic)['uid'],
                                      color: authController.userData['color'],
                                    )
                                  ],
                                ),
                              );
                      }),
                ],
              ),
            ),
            Obx(() => jobController.skillList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'No jobs found for category',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: jobController.skillList.contains('not-found')
                          ? Center(
                              child: Text('not-found',
                                  style: TextStyle(color: Colors.white)),
                            )
                          : ListView.builder(
                              itemCount: jobController.skillList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    tileColor: toColor(
                                        authController.userData['color']),
                                    title: Text(
                                      '${jobController.skillList[index].data()['jobTitle']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      "${jobController.skillList[index].data()['username']}\n${jobController.skillList[index].data()['jobTime']}    ${jobController.skillList[index].data()['jobType']}\n\n${jobController.skillList[index].data()['jobDesc']}",
                                      style: TextStyle(),
                                    ),
                                    trailing: Text('View'),
                                    isThreeLine: true,
                                    onTap: () {
                                      Get.to(() => JobDescriptionScreen(
                                          data: jobController.skillList[index]
                                              .data(),
                                          color: authController
                                              .userData['color']));
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
