import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SkillController extends GetxController {
  RxList<dynamic> skillData = [].obs;
  List data = [];
  RxList<dynamic> userSkills = [].obs;

  Future apicall(String searchData) async {
    String stringResponse = "";

    List listResponse = [];
    http.Response response;
    response = await http.get(Uri.parse(
        "https://api.apilayer.com/skills?q=$searchData&apikey=HlKKFDPPX1SCJj0isfPgmScIdzk5KDiE"));
    if (response.statusCode == 200) {
      stringResponse = response.body;
      print(stringResponse);
      data = json.decode(stringResponse);

      return data;

      // listResponse = mapResponse['data'];
    }
  }

  Future storeSkillsToFirestore(List skillData, String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'skills': FieldValue.arrayUnion(skillData),
        },
      );
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Some Error Occured');
    }
  }

  clearSkillData() {
    skillData = [].obs;
    userSkills = [].obs;
  }

  setSkillData() {
    skillData.value = data;

    update();
  }

  addSkillsData(String data) {
    userSkills.add(data);
  }

  removeSkillFromList(int num) {
    userSkills.removeAt(num);
  }
}
