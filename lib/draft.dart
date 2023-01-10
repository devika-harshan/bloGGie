import 'package:bloggie/home.dart';
import 'package:bloggie/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UserState.dart';

String docid = '';

class draft extends StatefulWidget {
  _draftState createState() => _draftState();
}

class _draftState extends State<draft> {
  String? docid = '';
  final myController = TextEditingController();
  final titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<UserState>(context, listen: false).getName();
  }

  @override
  Widget build(BuildContext context) {
    final String name = Provider.of<UserState>(context).userName;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffFCFCFC),
        body: Padding(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => mainscreen()),
                      );
                    },
                    child: Icon(Icons.close_sharp),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.transparent;
                        },
                      ),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () async {
                      if (myController.text.isEmpty ||
                          titleController.text.isEmpty) {
                        showTextEmptyAlert(context);
                      } else {
                        await FirebaseFirestore.instance
                            .collection('blogs')
                            .add({
                          'title': titleController.text,
                          'body': myController.text,
                          'author': name,
                          'date': DateFormat('dd/MM/yyyy,hh:mm')
                              .format(DateTime.now()),
                        }).then((value) {
                          docid = value.id;
                          // setPostID(value.id);
                          successAlert(context);
                        }).catchError((error) => errorAlert(context));

                        titleController.clear();
                        myController.clear();
                      }
                      await FirebaseFirestore.instance
                          .collection('blogs')
                          .doc(docid)
                          .update({'postid': docid});
                    },
                    child: Text("Publish",
                        style: TextStyle(
                            color: Color(0xff105712),
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0)),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                autofocus: true,
                decoration: new InputDecoration(
                  hintText: 'Enter Title',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Color(0xff057009),
                cursorHeight: 30,
              ),
              SizedBox(height: 25),
              TextField(
                controller: myController,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                autofocus: true,
                decoration: new InputDecoration(
                  hintText: 'Enter body..',
                  hintStyle: TextStyle(fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Color(0xff057009),
                cursorHeight: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  successAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Done'),
    );
    AlertDialog alert = AlertDialog(
      title: Text('Awesome'),
      content: Text("Your feed has been successfully published!"),
      actions: [
        okButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  showTextEmptyAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('OK'),
    );
    AlertDialog alert = AlertDialog(
      title: Text('Empty entry'),
      content: Text("Please write something before publishing"),
      actions: [
        okButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  errorAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Close'),
    );
    AlertDialog alert = AlertDialog(
      title: Text('Oops!'),
      content: Text("Please try again"),
      actions: [
        okButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
