import 'package:bloggie/Commentui.dart';
import 'package:bloggie/editprofile.dart';
import 'package:flutter/cupertino.dart';
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
      body: // Generated code for this Stack Widget...
          Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 4,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/737/600',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Container(
            width: 415.6,
            height: 271.3,
            decoration: BoxDecoration(
              color: Color(0xffad6bb9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.02, -0.32),
                  child: Container(
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
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0.51),
                  child: Text(
                    '@' + name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.02, 0.80),
                  child: Text(fname,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Align(
              alignment: AlignmentDirectional(-0.90, 0.07),
              child: Text(abt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Color(0xff575656))),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.90, 0.19),
            child: Divider(
              thickness: 1.5,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0.29),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  Text(loctn,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Color(0xff575656))),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.90, 0.39),
            child: Divider(
              thickness: 1.5,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.90, 0.46),
            child: InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text("Logout",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Color(0xff575656))),
            ),
          ),
        ],
      ),
    );
  }
}
