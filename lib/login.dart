import 'package:bloggie/Register.dart';

import 'package:bloggie/mainscreen.dart';

// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class login extends StatefulWidget {
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  String? email;
  String? password;
  bool invisible = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name

      home: Scaffold(
        backgroundColor: Color(0xffFCFCFC),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 60),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Image.asset(
                    'images/bloggie.PNG',
                    width: 201.6,
                    height: 100,
                    fit: BoxFit.cover,
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
                          onPressed: () {
                            // Future<void> _handleSignIn() async {
                            //   try {
                            //     print("object");
                            //     await _googleSignIn.signIn();
                            //   } catch (error) {
                            //     print(error);
                            //   }
                            // }
                          },
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
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
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
                      final user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email ?? "error",
                              password: password ?? "error");
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mainscreen()),
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
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text("Don't have an account? Sign up",
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
