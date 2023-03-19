import 'package:cloud_firestore/cloud_firestore.dart';

getUserData(String? uid) async {
  var userDoc =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();
  final userData = userDoc.data() as dynamic;
  String username = userDoc['username'];
  String jobCategory = userDoc['jobCategory'];
  String profilePhoto = userDoc['profilePhoto'];
  String country = userDoc['country'];
  int followers = 0;
  int following = 0;
  return username;
}
