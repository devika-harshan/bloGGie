import 'package:bloggie/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  String? fullname;
  String? gender;
  String? about;
  String? userlocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Column(
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                  // CircleAvatar(
                  //   radius: 45,
                  //   backgroundImage: NetworkImage(
                  //     'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg',
                  //   ),
                  // ),
                ],
              )),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff331070)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    fullname = value;
                  },
                  decoration: const InputDecoration(
                    floatingLabelStyle: TextStyle(color: Colors.purple),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Full Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff331070)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    gender = value.toUpperCase();
                  },
                  decoration: const InputDecoration(
                    floatingLabelStyle: TextStyle(color: Colors.purple),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.male_rounded),
                    labelText: 'Sex',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff331070)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  onChanged: (value) {
                    about = value;
                  },
                  decoration: const InputDecoration(
                    floatingLabelStyle: TextStyle(color: Colors.purple),
                    border: InputBorder.none,
                    labelText: 'About',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff331070)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    userlocation = value;
                  },
                  decoration: const InputDecoration(
                    floatingLabelStyle: TextStyle(color: Colors.purple),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.location_city_outlined),
                    labelText: 'Location',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 35, right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                      shadowColor: Color(0xffe2a1ed),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      minimumSize: Size(90, 50), //////// HERE
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Skip'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                      shadowColor: Color(0xffe2a1ed),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      minimumSize: Size(90, 50),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'fullname': fullname,
                        'gender': gender,
                        'about': about,
                        'location': userlocation,
                      });

                      if (FirebaseAuth.instance.currentUser != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
