import 'UserState.dart';
import 'package:bloggie/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

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
