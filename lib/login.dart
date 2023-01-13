import 'package:flutter/material.dart';
import 'package:bloggie/Register.dart';
import 'package:bloggie/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  String? email;
  String? password;
  bool invisible = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      theme: ThemeData(
        primarySwatch: Colors.purple,
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff540961)),
        )),
      ),
      //
      home: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/illust.PNG'),
              )),
            ),
            Text(
              "Login",
              style: TextStyle(
                  color: Color(0xff540961),
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 30, top: 25, right: 30, bottom: 20),
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
            Builder(builder: (context) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff540961),
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
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'invalid-email') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('The email address is badly formatted'),
                      ));
                    }
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'There is no user found with this email. The user may have been deleted'),
                      ));
                    }
                    if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'The password is invalid or the user does not have a password'),
                      ));
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
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: Text("Don't have an account? Sign up",
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
