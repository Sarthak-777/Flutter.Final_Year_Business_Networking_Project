import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  RxList skillList = [].obs;

  getSkillData(String skill) async {
    var result = await FirebaseFirestore.instance
        .collection('jobs')
        .where(
          'skills',
          arrayContains: skill,
        )
        .get();
    // print(result.docs[0].data());
    skillList.value = result.docs;
  }
}
