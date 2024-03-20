
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  FirebaseAuth_auth = FirebaseAuth.instance;
    Future<User?> logInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.logInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
  }
}
  
  