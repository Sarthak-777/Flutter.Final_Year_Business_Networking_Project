import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getUsername() async {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  return data['username'];
}

Future getBusinessUsername() async {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('business').doc(uid).get();
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  print(data['username']);
  return data['username'];
}
