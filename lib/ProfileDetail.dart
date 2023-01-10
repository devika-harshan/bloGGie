import 'package:bloggie/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ProfileDetail extends StatefulWidget {
  final myuser;
  const ProfileDetail({Key? key, required this.myuser}) : super(key: key);

  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
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
                    'Tell About You',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 10.0),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg',
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 16),
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
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 16),
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
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 16),
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
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 16),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => mainscreen()),
                      );
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
                          .doc(widget.myuser.user!.uid)
                          .update({
                        'fullname': fullname,
                        'gender': gender,
                        'about': about,
                        'location': userlocation,
                      });

                      print(widget.myuser.user!.uid);
                      if (widget.myuser != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mainscreen()),
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
