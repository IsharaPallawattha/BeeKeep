import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'live.dart';
import 'login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 //for web
 if(kIsWeb){
  await Firebase.initializeApp(
    options: FirebaseOptions(
  apiKey: "AIzaSyBkrHjRCexB_JCTC5aXUyfx03jfvmbKs7I", 
  appId: "1:944056849756:web:a7f9e4a1c98a3be20f5d99", 
  messagingSenderId: "944056849756",
  projectId: "beehivenew-5daa2",
  storageBucket:"beehivenew-5daa2.appspot.com"));
 }
 //for android mobile

 else if(Platform.isAndroid){
  await Firebase.initializeApp(
    options: FirebaseOptions(
  apiKey: "AIzaSyBkrHjRCexB_JCTC5aXUyfx03jfvmbKs7I", 
  appId: "1:944056849756:android:a7f9e4a1c98a3be20f5d99", 
  messagingSenderId: "944056849756",
  projectId: "beehivenew-5daa2",
  storageBucket:"beehivenew-5daa2.appspot.com"));
 } else {
   await Firebase.initializeApp();
 }
  runApp(const Login());
}
