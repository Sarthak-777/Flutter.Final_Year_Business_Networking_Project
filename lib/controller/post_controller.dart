import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  Future<String> storeImage(Uint8List file, String child, bool isPost) async {
    Reference ref = _storage.ref().child(child).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
