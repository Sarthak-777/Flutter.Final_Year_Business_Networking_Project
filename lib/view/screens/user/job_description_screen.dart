// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:final_project_workconnect/view/screens/user/apply_jobs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobDescriptionScreen extends StatelessWidget {
  var data;
  String color;
  JobDescriptionScreen({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List applicants = data['applicants'];
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // var contains = applicants.where((element) => element['uid'] == uid);

    return Scaffold(
        appBar: AppBar(
          title: Text('Job Details'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("jobs")
                .where("jobId", isEqualTo: data['jobId'])
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              }
              var data = snapshot.data!.docs[0].data() as dynamic;

              var contains =
                  data['applicants'].where((element) => element['uid'] == uid);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: color == '' ? Colors.red[600] : toColor(color),
                          // height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['jobTitle'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.grey[200]),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data['username'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[200]),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        child: Text(
                                          data['jobType'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[200]),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        child: Text(
                                          data['jobTime'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[200]),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey[800],
                          // height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.description,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Job Description',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey[200]),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data['jobDesc'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[200]),
                                  ),
                                  const SizedBox(height: 10),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey[800],
                          // height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.stacked_line_chart_outlined,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Experience',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey[200]),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data['jobExp'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[200]),
                                  ),
                                  const SizedBox(height: 10),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey[800],
                          // height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.hail_rounded,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Your Role',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey[200]),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data['jobResp'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[200]),
                                  ),
                                  const SizedBox(height: 10),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    contains.isNotEmpty
                        ? Text("Already Applied",
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.w700,
                                fontSize: 16))
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Get.to(() =>
                                    ApplyJobsScreen(jobId: data['jobId']));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.red[400],
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: const Text("Apply",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              );
            }));
  }
}
