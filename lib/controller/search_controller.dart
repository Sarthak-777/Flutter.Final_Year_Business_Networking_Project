import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList<dynamic> searchData = [].obs;
  RxList<dynamic> companyData = [].obs;
  RxList<dynamic> jobData = [].obs;

  searchFirebaseData(String data) async {
    var result = await FirebaseFirestore.instance
        .collection("users")
        .where("usernameSubstring", arrayContains: data)
        .get();
    var companyResult = await FirebaseFirestore.instance
        .collection("business")
        .where("orgNameSubstring", arrayContains: data)
        .get();
    var jobResult = await FirebaseFirestore.instance
        .collection("jobs")
        .where("skills", arrayContains: data)
        .get();

    searchData.value = result.docs;
    companyData.value = companyResult.docs;
    jobData.value = jobResult.docs;
  }
}
