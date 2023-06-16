import 'package:cloud_firestore/cloud_firestore.dart';

// Stream<List<DocumentSnapshot>> getUsersData(List<dynamic> uids) {
//   // Create a reference to the Firestore collection
//   CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('users');
//   CollectionReference businessCollection =
//       FirebaseFirestore.instance.collection('business');

//   // Create a query for the provided UIDs in user collection
//   Query userQuery = usersCollection.where('uid', whereIn: uids);

//   // Create a query for the provided UIDs in business collection
//   Query businessQuery = businessCollection.where('uid', whereIn: uids);

//   // Combine both queries using 'get()' method
//   Future<List<DocumentSnapshot>> combinedFuture =
//       userQuery.get().then((userDocs) {
//     if (userDocs.docs.isNotEmpty) {
//       return userDocs.docs;
//     } else {
//       return businessQuery.get().then((businessDocs) => businessDocs.docs);
//     }
//   });

//   // Return a stream of snapshots that match the combined query
//   return Stream.fromFuture(combinedFuture);
// }

Stream<List<DocumentSnapshot>> getUsersData(List<dynamic> uids) async* {
  // Create a reference to the Firestore collection
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference businessCollection =
      FirebaseFirestore.instance.collection('business');

  // Create a query for the provided UIDs in user collection
  Query userQuery = usersCollection.where('uid', whereIn: uids);

  // Create a query for the provided UIDs in business collection
  Query businessQuery = businessCollection.where('uid', whereIn: uids);

  // Get the snapshots from the user collection
  List<DocumentSnapshot> userSnapshots = (await userQuery.get()).docs;

  // Get the snapshots from the business collection
  List<DocumentSnapshot> businessSnapshots = (await businessQuery.get()).docs;

  // Combine the snapshots from both collections
  List<DocumentSnapshot> combinedSnapshots = []
    ..addAll(userSnapshots)
    ..addAll(businessSnapshots);

  // Yield the combined snapshots as a stream
  yield combinedSnapshots;
}
