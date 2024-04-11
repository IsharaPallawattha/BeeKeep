import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Stream<QuerySnapshot> getApiaryStream(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Apiary')
        .snapshots();
  }

  static Stream<QuerySnapshot> getHiveStream(String userId, String apiaryId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Apiary')
        .doc(apiaryId)
        .collection('Hives')
        .snapshots();
  }
}
