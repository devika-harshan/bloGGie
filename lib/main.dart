import 'dart:html';

import 'package:bloggie/Commentui.dart';
import 'package:bloggie/Profile.dart';
import 'package:bloggie/ProfileDetail.dart';
import 'package:bloggie/Register.dart';

import 'package:bloggie/feeddetails.dart';
import 'package:bloggie/home.dart';
import 'package:bloggie/mainscreen.dart';

import 'UserState.dart';

import 'package:bloggie/welcome.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyA1mxXRJNmqgFBoZeR7W0ROTPRhA0ZJN0E",
          projectId: "bloggie-f7af7",
          storageBucket: "bloggie-f7af7.appspot.com",
          messagingSenderId: "60642161939",
          appId: "1:60642161939:android:9090974ddead394dcf96e6"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: MaterialApp(
        home: welcome(),
      ),
    );
  }
}
