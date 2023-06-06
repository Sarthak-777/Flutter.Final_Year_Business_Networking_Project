import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Future<String> postComments(snap, text, user) async {
  String res = 'Some error occured';
  try {
    String commentId = Uuid().v1();

    print(user);
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(snap['postId'])
        .collection('comments')
        .doc(commentId)
        .set({
      'profilePic': user['profilePhoto'],
      'firstName': user['username'],
      'uid': user['uid'],
      'comment': text,
      'commentId': commentId,
      'date': DateTime.now(),
    });
    res = 'success';
  } catch (e) {
    res = e.toString();
    print(res);
  }
  return res;
}
