import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/model/business.dart';
import 'package:final_project_workconnect/model/user.dart';

class FirebaseHelper {
  static Future<MyUser?> getUserModelById(String uid) async {
    MyUser? userModel;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = MyUser.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  static Future<Business?> getBusinessModelById(String uid) async {
    Business? businessModel;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("business").doc(uid).get();

    if (docSnap.data() != null) {
      businessModel = Business.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return businessModel;
  }
}
