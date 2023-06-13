import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class BusinessController extends GetxController {
  Rx<String?> _uid = "".obs;
  final Rx<Map<String, dynamic>> _business = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get business => _business.value;

  updateBusinessId(String? uid) async {
    _uid.value = uid;
    await getBusinessData();
  }

  getBusinessData() async {
    var businessDoc = await FirebaseFirestore.instance
        .collection("business")
        .doc(_uid.value)
        .get();
    final businessData = businessDoc.data() as dynamic;
    String orgName = businessDoc['orgName'];
    String jobCategory = businessDoc['jobCategory'];
    String profilePhoto = businessDoc['profilePhoto'];
    String phoneNo = businessDoc['phoneNo'];

    String jobDesc = businessDoc['jobDesc'];
    List followers = businessDoc['followers'];

    _business.value = {
      'followers': followers,
      'profilePhoto': profilePhoto,
      'orgName': orgName,
      'jobCategory': jobCategory,
      'phoneNo': phoneNo,
      'jobDesc': jobDesc,
    };

    update();
  }

  Future<String> storeImage(File file) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePic')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadImage(File imageFile) async {
    String res = 'Some Error Occured';
    try {
      String fileUrl = await storeImage(imageFile);
      await FirebaseFirestore.instance
          .collection('business')
          .doc(_uid.value)
          .update({
        'profilePhoto': fileUrl,
      });
      Get.snackbar('Success', 'Image Uploaded');
    } catch (e) {
      Get.snackbar('Error', res);
    }
  }

  Future<String?> getUserImage(String? uid) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var userData = userDoc.data();
    print(userData);
    String userImage = userDoc['profilePhoto'];
    print(userImage);
    return userImage;
  }
}
