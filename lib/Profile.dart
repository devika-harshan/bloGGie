import 'package:bloggie/editprofile.dart';
import 'package:bloggie/welcome.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloggie/UserState.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String usersex = "MALE";
  @override
  void initState() {
    super.initState();
    Provider.of<UserState>(context, listen: false).getName();
  }

  @override
  Widget build(BuildContext context) {
    final String name = Provider.of<UserState>(context).userName;
    final String fname = Provider.of<UserState>(context).userFull;
    final String loctn = Provider.of<UserState>(context).userLoc;
    final String gen = Provider.of<UserState>(context).userGen;
    final String abt = Provider.of<UserState>(context).userAbout;
    return Scaffold(
      body: 
          Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.84, -0.82),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => editprofile()),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: usersex == gen
                      ? Image.network(
                          'https://static.vecteezy.com/system/resources/previews/004/819/327/original/male-avatar-profile-icon-of-smiling-caucasian-man-vector.jpg',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          'https://static.vecteezy.com/system/resources/previews/004/819/322/original/female-avatar-woman-profile-icon-for-network-vector.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '@' + name,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            height: 270,
            decoration: BoxDecoration(
              color: Color(0xff744481),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 18.0, bottom: 10),
                child: Text(
                  fname,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Color(0xff575656)),
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 18.0, bottom: 15),
                child: Text(
                  abt,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Color(0xff575656)),
                ),
              ),
              Divider(
              thickness: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10.0, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(
                      loctn,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Color(0xff575656)),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 18.0, bottom: 15),
                child: InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => welcome()));
                  },
                  child: Text('Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Color(0xff575656))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
