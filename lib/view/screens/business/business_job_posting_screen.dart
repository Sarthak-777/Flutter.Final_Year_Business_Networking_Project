import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/view/screens/business/business_job_description_screen.dart';
import 'package:final_project_workconnect/controller/business/business_job_postings.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JobPostingScreen extends StatefulWidget {
  const JobPostingScreen({super.key});

  @override
  State<JobPostingScreen> createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen> {
  JobPostingsController controller = Get.put(JobPostingsController());
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    controller.getBusinessListings(uid!);
    return Scaffold(
      body: Container(
        color: iconBool ? Colors.black : Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "WorkConnectBusiness",
                      style: GoogleFonts.roboto(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: iconBool ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Your Job Listings',
                style: TextStyle(fontSize: 16),
              ),
              Obx(() => controller.Listings.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: Text(
                          'No jobs found for category',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Expanded(
                      child: controller.Listings.contains(
                              "No Job Listings Yet !!!")
                          ? Center(
                              child: Text('not-found',
                                  style: TextStyle(color: Colors.white)),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: controller.Listings.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    tileColor: Colors.red,
                                    title: Text(
                                      '${controller.Listings[index].data()['jobTitle']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: controller.Listings[index]
                                                  .data()['verified']
                                              ? Colors.green[700]
                                              : Colors.red[700]),
                                    ),
                                    subtitle: Text(
                                      "${controller.Listings[index].data()['username']}\n${controller.Listings[index].data()['jobTime']}    ${controller.Listings[index].data()['jobType']}\n\n${controller.Listings[index].data()['jobDesc']}",
                                      style: TextStyle(),
                                    ),
                                    trailing: Text('View'),
                                    isThreeLine: true,
                                    onTap: () {
                                      Get.to(() => BusinessJobDescriptionScreen(
                                            data: controller.Listings[index]
                                                .data(),
                                          ));
                                    },
                                  ),
                                );
                              },
                            ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
