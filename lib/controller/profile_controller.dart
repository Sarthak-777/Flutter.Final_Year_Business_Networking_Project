import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

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

    int followers = 0;
    int following = 0;
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'profilePhoto': profilePhoto,
      'username': username,
      'country': country,
      'jobCategory': jobCategory,
      'city': city,
    };

    update();
  }

  Future<String> storeImage(Uint8List file) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePic')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadImage(Uint8List imageFile) async {
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
}
