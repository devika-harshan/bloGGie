import 'package:bloggie/mainscreen.dart';
import 'Register.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class welcome extends StatefulWidget {
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name

      home: Scaffold(
        backgroundColor: Color(0xffFEF3F0),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                  child: Image.asset(
                    'images/blogg.png',
                    width: 201.6,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              'Express more than writings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 20),
            Container(
              child: Image.asset(
                'images/drib1.PNG',
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shadowColor: Color(0xff7d817e),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(330, 45),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: Text('Join for free'),
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
              child: Text(
                "if you have an account,Sign in",
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
