import 'package:bloggie/ProfileDetail.dart';
import 'package:bloggie/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:bloggie/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? password;
  String? username;
  bool invisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name

      home: Scaffold(
        backgroundColor: Color(0xffFCFCFC),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 6),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: 'logo',
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Image.asset(
                      'images/bloggie.PNG',
                      width: 201.6,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Express more than writings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: SizedBox(
                          child: SignInButton(
                            Buttons.Facebook,
                            text: "Facebook",
                            onPressed: () {},
                          ),
                          width: 142.0,
                          height: 45.0),
                    ),
                    SizedBox(
                        child: SignInButton(
                          Buttons.Google,
                          text: "Google",
                          onPressed: () {},
                        ),
                        width: 142.0,
                        height: 45.0),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('or'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffa8a6a6)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            username = value;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                        TextField(
                          obscureText: invisible,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Password',
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  invisible = !invisible;
                                });
                              },
                              child: invisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  child: Text(
                      "By clicking below you agree to bloGGie's Terms of Service & Privacy Policy.",
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    onPrimary: Colors.white,
                    shadowColor: Color(0xffe2a1ed),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    minimumSize: Size(310, 50), //////// HERE
                  ),
                  onPressed: () async {
                    try {
                      final newuser = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email ?? 'error',
                        password: password ?? 'error',
                      );

                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(newuser.user!.uid)
                          .set({'uname': username});

                      if (newuser != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileDetail(
                                    myuser: newuser,
                                  )),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Start Reading'),
                ),
                SizedBox(height: 20),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.transparent;
                      },
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  child: Text("Have an account?Log in",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
