// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/controller/job_controller.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:final_project_workconnect/view/screens/user/skills_screen.dart';

class jobSkillWidget extends StatelessWidget {
  String? uid;
  String color;
  jobSkillWidget({
    Key? key,
    required this.uid,
    required this.color,
  }) : super(key: key);

  JobController jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (int i = 0;
                        i < snapshot.data.data()['skills'].length;
                        i++) ...[
                      InkWell(
                        onTap: () {
                          print(snapshot.data.data()['skills'][i]);
                          jobController
                              .getSkillData(snapshot.data.data()['skills'][i]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color:
                                color == '' ? Colors.red[600] : toColor(color),
                            padding: EdgeInsets.all(10),
                            child: Text(snapshot.data.data()['skills'][i],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              }
            },
          ),
        ));
  }
}
