import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBkrHjRCexB_JCTC5aXUyfx03jfvmbKs7I",
          appId: "1:944056849756:android:a7f9e4a1c98a3be20f5d99",
          messagingSenderId: "609734600087",
          projectId: "beehivenew-5daa2",
          storageBucket: "beehivenew-5daa2.appspot.com"));
  runApp(const MyApp());
}
