// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project_workconnect/functions/sendEmail.dart';
import 'package:final_project_workconnect/view/screens/user/jobs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:final_project_workconnect/controller/job_controller.dart';
import 'package:final_project_workconnect/view/screens/user/resume_generator.dart';
import 'package:final_project_workconnect/view/widgets/dividerWidget.dart';
import 'package:final_project_workconnect/view/widgets/textInputWidget.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ApplyJobsScreen extends StatefulWidget {
  String jobId;
  ApplyJobsScreen({
    Key? key,
    required this.jobId,
  }) : super(key: key);

  @override
  State<ApplyJobsScreen> createState() => _ApplyJobsScreenState();
}

class _ApplyJobsScreenState extends State<ApplyJobsScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _summaryController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  JobController jobController = Get.put(JobController());
  var result = null;

  @override
  Widget build(BuildContext context) {
    print(result);
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Job"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            result != null
                ? InkWell(
                    onTap: () async {
                      result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'jpg'],
                      );
                      setState(() {});
                    },
                    child: Text(
                      'resume.pdf',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'jpg'],
                          );
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Upload Resume',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.upload_file_outlined,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DividerWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => ResumeForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Generate Resume',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.upload_file_outlined,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            TextInputWidget(
                controller: _phoneController,
                myIcon: Icons.phone,
                myLabelText: "Enter Phone No"),
            const SizedBox(
              height: 20,
            ),
            TextInputWidget(
                controller: _usernameController,
                myIcon: Icons.verified_user,
                myLabelText: "Enter Username"),
            const SizedBox(
              height: 20,
            ),
            TextInputWidget(
                controller: _emailController,
                myIcon: Icons.email,
                myLabelText: "Enter Email No"),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: _summaryController,
              decoration: const InputDecoration(
                  hintText: 'Enter your summary',
                  contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () async {
                  if (result != null &&
                      _phoneController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _usernameController.text.isNotEmpty &&
                      _summaryController.text.isNotEmpty) {
                    File file = File(result!.files.single.path!);
                    await sendEmail(
                        name: _usernameController.text,
                        email: _emailController.text,
                        subject: "Job Application Sent",
                        message:
                            "Thank you for using workconnect. Your application has been sent");
                    jobController.applyJob(
                        FirebaseAuth.instance.currentUser!.uid,
                        _usernameController.text,
                        file,
                        _phoneController.text,
                        _emailController.text,
                        _summaryController.text,
                        widget.jobId);
                    Get.snackbar("success", "Applied for Job");
                    Get.off(() => JobsScreen());
                  } else {
                    // User canceled the picker
                    Get.snackbar("Error", "Please enter all the fields");
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.red[400],
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("Apply",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
