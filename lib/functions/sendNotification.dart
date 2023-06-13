import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Future sendNotification(String uid, message) async {
  String notificationId = Uuid().v1();
  print('this runs');
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .doc(notificationId)
        .set({
      'uid': uid,
      'notificationId': notificationId,
      'message': message,
      'date': DateTime.now(),
    });
  } catch (e) {
    print(e);
  }
}
