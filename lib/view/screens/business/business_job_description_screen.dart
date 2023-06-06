// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:final_project_workconnect/controller/business/business_job_postings.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:final_project_workconnect/view/screens/business/business_applicants_screen.dart';
import 'package:final_project_workconnect/view/screens/user/apply_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class BusinessJobDescriptionScreen extends StatelessWidget {
  var data;
  var color;

  BusinessJobDescriptionScreen({
    Key? key,
    required this.data,
    this.color = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JobPostingsController controller = Get.put(JobPostingsController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: color == '' ? Colors.grey.shade800 : toColor(color),
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data['verified']
                              ? Text('Verfied',
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w700))
                              : Text('X Not Verified',
                                  style: TextStyle(
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w700)),
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
                                  borderRadius: BorderRadius.circular(10),
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
                                  borderRadius: BorderRadius.circular(10),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => BusinessApplicantScreen(
                        jobId: data['jobId'],
                      ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.green[700],
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("View Applicants",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  // Get.to(() => ApplyJobsScreen(jobId: data['jobId']));
                  controller.deleteListing(data['jobId']);
                  Get.snackbar("Success", "Job Removal Success");
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.red[500],
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("Remove/Delete",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
