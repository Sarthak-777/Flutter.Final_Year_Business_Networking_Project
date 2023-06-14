import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfUidExists(String uid) async {
  try {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('your-collection')
        .where('uidField', isEqualTo: uid)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  } catch (error) {
    // Handle the error appropriately
    print('Error checking UID existence: $error');
    return false;
  }
}
