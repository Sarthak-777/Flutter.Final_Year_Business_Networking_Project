import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/functions/getAllPosts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizeProfileController extends GetxController {
  String changeProfileTheme(String theme) {
    String profTheme = '';
    if (theme == 'red') {
      profTheme = '#8b0000';
    } else if (theme == 'blue') {
      profTheme = '#00008B';
    } else if (theme == 'green') {
      profTheme = '#023020';
    } else if (theme == 'black') {
      profTheme = '#424242';
    }
    return profTheme;
  }

  Future customizeDataFireabase(
      String description, String jobCategory, String theme) async {
    try {
      if (description == '') {
        var descriptionDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        final descriptionData = descriptionDoc.data() as dynamic;
        description = descriptionData['jobDesc'];
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'jobDesc': description,
        'jobCategory': jobCategory,
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'color': changeProfileTheme(theme),
      });

      getAllPosts(changeProfileTheme(theme));

      Get.back();
    } catch (e) {
      print(e.toString());
    }
  }
}
