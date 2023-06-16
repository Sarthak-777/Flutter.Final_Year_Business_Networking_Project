import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  Rx<String?> _uid = "".obs;
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  updateUserId(String? uid) async {
    _uid.value = uid;
    await getUserData();
  }

  getUserData() async {
    var userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(_uid.value)
        .get();
    final userData = userDoc.data() as dynamic;
    String username = userDoc['username'];
    String jobCategory = userDoc['jobCategory'];
    String profilePhoto = userDoc['profilePhoto'];
    String country = userDoc['country'];
    String city = userDoc['city'];
    String jobDesc = userDoc['jobDesc'];
    String color = userDoc['color'];
    List followers = userDoc['followers'];
    List following = userDoc['following'];

    _user.value = {
      'followers': followers,
      'following': following,
      'profilePhoto': profilePhoto,
      'username': username,
      'country': country,
      'jobCategory': jobCategory,
      'city': city,
      'jobDesc': jobDesc,
      'color': color,
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
          .collection('users')
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

  Future<String?> getBusinessUserImage(String? uid) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('business').doc(uid).get();
    var userData = userDoc.data();
    print(userData);
    String userImage = userDoc['profilePhoto'];
    print(userImage);
    return userImage;
  }
}
