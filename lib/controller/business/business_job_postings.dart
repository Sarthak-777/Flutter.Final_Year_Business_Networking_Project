import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class JobPostingsController extends GetxController {
  RxList Listings = [].obs;
  getBusinessListings(String uid) async {
    print(uid);
    var result = await FirebaseFirestore.instance
        .collection('jobs')
        .where('uid', isEqualTo: uid)
        .get();
    print(result.docs);
    if (result.docs.isEmpty) {
      Listings.value = ["No Job Listings Yet !!!"];
    } else {
      Listings.value = result.docs;
    }
  }

  deleteListing(String jobId) async {
    print('this runs');
    var data =
        await FirebaseFirestore.instance.collection('jobs').doc(jobId).delete();
  }
}
