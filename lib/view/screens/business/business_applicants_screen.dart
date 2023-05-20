import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/view/screens/business/business_applicant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class BusinessApplicantScreen extends StatelessWidget {
  String jobId;
  BusinessApplicantScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    print(jobId);
    return Scaffold(
        appBar: AppBar(
          title: Text('View Applicants'),
          backgroundColor: iconBool ? Colors.black : Colors.grey[200],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("jobs")
              .where("jobId", isEqualTo: jobId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }
            var data = snapshot.data!.docs[0].data() as dynamic;
            print(data['applicants'][0]['email']);

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 0),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: InkWell(
                          onTap: () {
                            Get.to(() =>
                                ApplicantDetails(data: data['applicants'][0]));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                data['applicants'][index]['email'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                data['applicants'][index]['phone'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            );
          },
        ));
  }
}
