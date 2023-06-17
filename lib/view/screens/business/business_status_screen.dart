import 'package:final_project_workconnect/view/screens/business/business_applicant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessStatusScreen extends StatelessWidget {
  var data;
  BusinessStatusScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicant Status'),
      ),
      body: Column(children: [
        for (var applicant in data)
          InkWell(
            onTap: () {
              Get.to(() => ApplicantDetails(
                  applicantData: applicant, jobId: applicant['jobId']));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    applicant['email'],
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(
                    applicant['phone'],
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
            ),
          )
      ]),
    );
  }
}
