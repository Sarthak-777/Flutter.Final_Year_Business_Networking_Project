import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/view/screens/user/skills_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class skillsWidget extends StatelessWidget {
  String? uid;
  skillsWidget({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            onTap: () {
              Get.to(() => SkillsScreen());
            },
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.red[600],
                            padding: EdgeInsets.all(10),
                            child: Text(snapshot.data.data()['skills'][i],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ],
                      uid == FirebaseAuth.instance.currentUser!.uid
                          ? InkWell(
                              onTap: () {
                                Get.to(() => SkillsScreen());
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.blueGrey[300],
                                  padding: EdgeInsets.all(10),
                                  child: Text(" + ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
}
