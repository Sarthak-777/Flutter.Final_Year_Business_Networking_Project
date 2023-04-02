import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/functions/getAllPosts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomizeBusinessProfileController extends GetxController {
  Future customizeDataFireabase(String description) async {
    try {
      if (description == '') {
        var descriptionDoc = await FirebaseFirestore.instance
            .collection('business')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        final descriptionData = descriptionDoc.data() as dynamic;
        description = descriptionData['jobDesc'];
      }
      await FirebaseFirestore.instance
          .collection('business')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'jobDesc': description,
      });

      Get.back();
    } catch (e) {
      print(e.toString());
    }
  }
}
