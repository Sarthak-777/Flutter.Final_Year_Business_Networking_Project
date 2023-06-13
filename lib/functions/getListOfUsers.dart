import 'package:cloud_firestore/cloud_firestore.dart';

// Stream<List<DocumentSnapshot>> getUsersData(List<dynamic> uids) {
// //   print(uids);
// //   // Create a reference to the Firestore collection
// //   CollectionReference usersCollection =
// //       FirebaseFirestore.instance.collection('users');
// //   CollectionReference businessCollection =
// //       FirebaseFirestore.instance.collection('business');

// //   // Create a query for the provided UIDs
// //   Query query = usersCollection.where('uid', whereIn: uids);
// //   Query businessQuery = businessCollection.where('uid', whereIn: uids);

// //   // Return a stream of snapshots that match the query
// //   if(query.snapshots())
// //   return query.snapshots().map((QuerySnapshot snapshot) => snapshot.docs);
// // }

Stream<List<DocumentSnapshot>> getUsersData(List<dynamic> uids) {
  // Create a reference to the Firestore collection
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference businessCollection =
      FirebaseFirestore.instance.collection('business');

  // Create a query for the provided UIDs in user collection
  Query userQuery = usersCollection.where('uid', whereIn: uids);

  // Create a query for the provided UIDs in business collection
  Query businessQuery = businessCollection.where('uid', whereIn: uids);

  // Combine both queries using 'get()' method
  Future<List<DocumentSnapshot>> combinedFuture =
      userQuery.get().then((userDocs) {
    if (userDocs.docs.isNotEmpty) {
      return userDocs.docs;
    } else {
      return businessQuery.get().then((businessDocs) => businessDocs.docs);
    }
  });

  // Return a stream of snapshots that match the combined query
  return Stream.fromFuture(combinedFuture);
}
