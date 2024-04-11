import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<bool> addUserDetails(Map<String, dynamic> userInfoMap,String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .set(userInfoMap);
      return true; // Return true if the operation is successful
    } catch (e) {
      print("Error adding user details: $e");
      return false; // Return false if there's an error
    }
  }


  //get data
  Future<Stream<QuerySnapshot>> getUserDetails() async{
    return FirebaseFirestore.instance.collection("Users").snapshots();
  }

  //update
  Future updateUserDetails(String id, Map<String,dynamic>updateInfo) async {
    return await FirebaseFirestore.instance.collection("Users").doc(id).update(updateInfo);
  }

  //delete
  Future deleteUserDetails(String id) async {
    try {
      // Get the reference to the document using its ID
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('Users').doc(id);

      // Delete the document
      await documentReference.delete();

      print('Document with ID $id deleted successfully.');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<bool> addApiaryDetails(Map<String, dynamic> apiaryInfoMap,String userID, String apiaryID) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection("Apiary")
          .doc(apiaryID)
          .set(apiaryInfoMap);
      return true; // Return true if the operation is successful
    } catch (e) {
      print("Error adding user details: $e");
      return false; // Return false if there's an error
    }
  }


  //get data
  Future<Stream<QuerySnapshot>> getApiaryDetails(String userID) async {
    try {
      return FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection("Apiary")
          .snapshots();
    } catch (e) {
      print('Error getting apiary details: $e');
      rethrow; // Re-throw the error for higher-level handling
    }
  }

  Future<void> updateApiaryDetails(String userID, String apiaryID, Map<String, dynamic> updateInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection("Apiary")
          .doc(apiaryID)
          .update(updateInfo);
      print('Apiary details updated successfully.');
    } catch (e) {
      print('Error updating apiary details: $e');
      rethrow; // Re-throw the error for higher-level handling
    }
  }

  //delete
  Future deleteApiaryDetails(String userID, String apiaryID) async {
    try {
      // Get the reference to the document using its ID
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('Users').doc(userID).collection('Apiary').doc(apiaryID);

      // Delete the document
      await documentReference.delete();

      print('Deleted successfully.');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }


  Future<bool> addHiveDetails(Map<String, dynamic> apiaryInfoMap,String userID, String apiaryID, String hiveID) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection("Apiary")
          .doc(apiaryID)
          .collection("Hives")
          .doc(hiveID)
          .set(apiaryInfoMap);
      return true; // Return true if the operation is successful
    } catch (e) {
      print("Error adding user details: $e");
      return false; // Return false if there's an error
    }
  }


  //get data
  Future<Stream<QuerySnapshot>> getHiveDetails(String userID, String apiaryID) async {
    try {
      return FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection("Apiary")
          .doc(apiaryID)
          .collection("Hives")
          .snapshots();
    } catch (e) {
      print('Error getting Hive details: $e');
      rethrow; // Re-throw the error for higher-level handling
    }
  }

  Future<void> updateHiveDetails(String userID, String apiaryID, String hiveID, Map<String, dynamic> updateInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection("Apiary")
          .doc(apiaryID)
          .collection("Hives")
          .doc(hiveID)
          .update(updateInfo);
      print('Hive details updated successfully.');
    } catch (e) {
      print('Error updating hive details: $e');
      rethrow; // Re-throw the error for higher-level handling
    }
  }

  //delete
  Future deleteHiveDetails(String userID, String apiaryID, String hiveID) async {
    try {
      // Get the reference to the document using its ID
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('Users').doc(userID).collection('Apiary').doc(apiaryID).collection("Hives").doc(hiveID);

      // Delete the document
      await documentReference.delete();

      print('Deleted successfully.');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}