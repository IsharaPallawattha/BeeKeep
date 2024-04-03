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
    return await FirebaseFirestore.instance.collection("Users").snapshots();
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

}