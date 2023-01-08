import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserState extends ChangeNotifier {
  String userName = '';
  String userGen = '';
  String userAbout = '';
  String userLoc = '';
  String userFull = '';

  Future<void> getName() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userName = (value.data()?['uname'] ?? "Username Error");
      userGen = (value.data()?['gender'] ?? "Male");
      userAbout = (value.data()?['about'] ?? "Hey there! I am using bloGGie");
      userFull = (value.data()?['fullname'] ?? "");
      userLoc = (value.data()?['location'] ?? "Location not added");
      notifyListeners();
    });
  }
}
