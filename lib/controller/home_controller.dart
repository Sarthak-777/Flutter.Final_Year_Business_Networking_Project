import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool theme = false.obs;
  Future<bool> handleLikes(String uid, String postId, List likes) async {
    if (likes.contains(uid)) {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
      return false;
    } else {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
      return true;
    }
  }

  Future<String> commentsCount(snap) async {
    String count = '0';
    var snapshots = await FirebaseFirestore.instance
        .collection('posts')
        .doc(snap['postId'])
        .collection('comments')
        .get();
    int data = snapshots.docs.length;
    count = data.toString();
    return count;
  }

  void changeTheme(bool theme) {
    if (theme == true) {
      Get.changeTheme(darkTheme);
    } else {
      Get.changeTheme(lightTheme);
    }
  }
}
