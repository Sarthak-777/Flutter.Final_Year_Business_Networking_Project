import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class JobController extends GetxController {
  RxList skillList = [].obs;

  getSkillData(String skill) async {
    var result = await FirebaseFirestore.instance
        .collection('jobs')
        .where(
          'skills',
          arrayContains: skill,
        )
        .where('verified', isEqualTo: true)
        .get();
    print(result.docs);
    if (result.docs.isEmpty) {
      skillList.value = ['not-found'];
    } else {
      skillList.value = result.docs;
    }
  }

  getRecommendedSkillData() async {
    var result = await FirebaseFirestore.instance
        .collection('jobs')
        .where('verified', isEqualTo: true)
        .get();
    print(result.docs);
    if (result.docs.isEmpty) {
      skillList.value = ['not-found'];
    } else {
      skillList.value = result.docs;
    }
  }

  uploadFile(File file, String jobId) async {
    String res = 'Some Error Occured';
    try {
      String fileUrl = await storeFile(file);
      await FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
        'file': fileUrl,
      });
      Get.snackbar('Success', 'File Uploaded');
    } catch (e) {
      Get.snackbar('Error', res);
    }
  }

  Future<String> storeFile(File file) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('resume')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  applyJob(String uid, String username, File file, String phone, String email,
      String summary, String jobId) async {
    String fileUrl = await storeFile(file);

    await FirebaseFirestore.instance.collection("jobs").doc(jobId).update({
      "applicants": FieldValue.arrayUnion([
        {
          'uid': uid,
          'username': username,
          'file': fileUrl,
          'phone': phone,
          'email': email,
          'summary': summary,
          'status': "pending",
        }
      ])
    });
  }
}
