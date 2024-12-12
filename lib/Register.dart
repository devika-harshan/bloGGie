import 'package:bloggie/ProfileDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? exep;
  String? password;
  String? username;
  bool invisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff540961)),
        )),
      ),
      // Application name

      home: Scaffold(
        backgroundColor: Color(0xffFCFCFC),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/illust2.PNG'),
                )),
              ),
            ),
            Text(
              "Register",
              style: TextStyle(
                  color: Color(0xff540961),
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25),
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
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: InputDecoration(
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
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: Text(
                  "By clicking below you agree to bloGGie's Terms of Service & Privacy Policy.",
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 10),
            Builder(builder: (context) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff540961),
                  foregroundColor: Colors.white,
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
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileDetail(
                                  myuser: newuser,
                                )),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'invalid-email') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('The email address is badly formatted'),
                      ));
                    }
                    if (e.code == 'weak-password') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Password should be at least 6 characters')));
                    }
                    if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'The email address is already in use by another account')));
                    }

                    print(e);
                  }
                },
                child: Text('Start Reading'),
              );
            }),
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
              child: Text("Have an account? Log in",
                  style: TextStyle(
                      color: Color(0xff540961),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
            )
          ],
        ),
      ),
    );
  }
}
