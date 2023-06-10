import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

getAllPosts(String color) async {
  QuerySnapshot result = await FirebaseFirestore.instance
      .collection('posts')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  print(result.docs.map((data) => FirebaseFirestore.instance
          .collection('posts')
          .doc((data.data() as dynamic)['postId'])
          .update({
        'color': color,
      })));
}
