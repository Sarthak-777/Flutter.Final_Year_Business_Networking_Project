import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:final_project_workconnect/model/job.dart';

class CreateJobController extends GetxController {
  void addJobsToDB(
    String jobTitle,
    String jobDesc,
    String jobResp,
    String jobExp,
    String jobTime,
    String jobType,
    List skills,
    String username,
    String uid,
  ) async {
    if (jobTitle.isNotEmpty &&
        jobDesc.isNotEmpty &&
        jobResp.isNotEmpty &&
        jobTime.isNotEmpty &&
        jobType.isNotEmpty) {
      print(skills);
      String id = const Uuid().v1();
      Job job = Job(
        jobDesc: jobDesc,
        jobExp: jobExp,
        jobId: id,
        jobResp: jobResp,
        jobTime: jobTime,
        jobTitle: jobTitle,
        jobType: jobType,
        skills: skills,
        username: username,
        uid: uid,
        applicants: [],
      );
      await FirebaseFirestore.instance
          .collection('jobs')
          .doc(id)
          .set(job.toJson());
    } else {
      Get.snackbar("Error", "Please Enter all the fields");
    }
  }
}
