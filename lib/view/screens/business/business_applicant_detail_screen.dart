import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/view/screens/business/business_job_posting_screen.dart';
import 'package:final_project_workconnect/view/screens/business/business_landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicantDetails extends StatelessWidget {
  var applicantData;
  String jobId;
  ApplicantDetails(
      {super.key, required this.applicantData, required this.jobId});

  @override
  Widget build(BuildContext context) {
    print(applicantData['status']);
    return Scaffold(
        appBar: AppBar(
          title: Text('Applicant Details'),
          backgroundColor: iconBool ? Colors.black : Colors.grey[200],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Applicant name: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(applicantData['username'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Applicant email: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(applicantData['email'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Applicant contact no: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(applicantData['phone'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Applicant summary: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(applicantData['summary'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse(applicantData['file']),
                        mode: LaunchMode
                            .externalApplication); //launch is from url_launcher package to launch URL

                    // final Uri url = Uri.parse(data['file']);
                    // if (!await launchUrl(url)) {
                    //   throw Exception('Could not launch url');
                    // }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.blue[700],
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("View Applicant CV",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
              applicantData['status'] != 'pending'
                  ? Text('Applicant Accepted')
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: InkWell(
                            onTap: () async {
                              var data = await FirebaseFirestore.instance
                                  .collection('jobs')
                                  .doc(jobId)
                                  .get();

                              var applicants = data.data()!['applicants'];
                              for (int i = 0; i < applicants.length; i++) {
                                if (applicants[i]['uid'] ==
                                    applicantData['uid']) {
                                  await FirebaseFirestore.instance
                                      .collection("jobs")
                                      .doc(jobId)
                                      .update({
                                    'applicants': FieldValue.arrayUnion([
                                      {
                                        'email': applicantData['email'],
                                        'file': applicantData['file'],
                                        'phone': applicantData['phone'],
                                        'status': "accepted",
                                        'summary': applicantData['summary'],
                                        'uid': applicantData['uid'],
                                        'username': applicantData['username'],
                                      }
                                    ])
                                  });
                                  FirebaseFirestore.instance
                                      .collection("jobs")
                                      .doc(jobId)
                                      .update({
                                    'applicants': FieldValue.arrayRemove([
                                      {
                                        'email': applicantData['email'],
                                        'file': applicantData['file'],
                                        'phone': applicantData['phone'],
                                        'status': applicantData['status'],
                                        'summary': applicantData['summary'],
                                        'uid': applicantData['uid'],
                                        'username': applicantData['username'],
                                      }
                                    ])
                                  });
                                  Get.snackbar("success", "Applicant Accepted");
                                  Get.to(() => LandingScreen());
                                }
                                // if(applicants[i]['uid'] == )
                              }

                              // var collection =
                              //     FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
                              //       'applicants':
                              //     });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.green[700],
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Text("Accept Applicant",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: InkWell(
                            onTap: () async {
                              var data = await FirebaseFirestore.instance
                                  .collection('jobs')
                                  .doc(jobId)
                                  .get();

                              var applicants = data.data()!['applicants'];
                              for (int i = 0; i < applicants.length; i++) {
                                if (applicants[i]['uid'] ==
                                    applicantData['uid']) {
                                  await FirebaseFirestore.instance
                                      .collection("jobs")
                                      .doc(jobId)
                                      .update({
                                    'applicants': FieldValue.arrayUnion([
                                      {
                                        'email': applicantData['email'],
                                        'file': applicantData['file'],
                                        'phone': applicantData['phone'],
                                        'status': "rejected",
                                        'summary': applicantData['summary'],
                                        'uid': applicantData['uid'],
                                        'username': applicantData['username'],
                                      }
                                    ])
                                  });
                                  FirebaseFirestore.instance
                                      .collection("jobs")
                                      .doc(jobId)
                                      .update({
                                    'applicants': FieldValue.arrayRemove([
                                      {
                                        'email': applicantData['email'],
                                        'file': applicantData['file'],
                                        'phone': applicantData['phone'],
                                        'status': applicantData['status'],
                                        'summary': applicantData['summary'],
                                        'uid': applicantData['uid'],
                                        'username': applicantData['username'],
                                      }
                                    ])
                                  });
                                  Get.snackbar("success", "Applicant Rejected");
                                  Get.to(() => LandingScreen());
                                }
                                // if(applicants[i]['uid'] == )
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.red[700],
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Text("Reject Applicant",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ));
  }
}
