import 'package:bloggie/feeddetails.dart';
import 'package:provider/provider.dart';
import 'UserState.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String mydoc = '';
User? loggedInUser;

class home extends StatefulWidget {
  final String? uname;
  const home({Key? key, this.uname}) : super(key: key);
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserState>(context, listen: false).getName();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;

      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = Provider.of<UserState>(context).userName;
    return MaterialApp(
      // Application name

      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'home',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.black,
          //
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('blogs').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => feeddetails(
                                        body: document['body'],
                                        title: document['title'],
                                        date: document['date'],
                                        author: document['author'],
                                        documentid: document['postid'])),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 12.0, 0.0, 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              document['title'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22.0),
                                            ),
                                            flex: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              document['author'],
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                            Text(
                                              document['date'],
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        // Icon(Icons.favorite_border_outlined),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*var docSnapshot = await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      if (docSnapshot.exists) {
                        Map<String, dynamic> data = docSnapshot.data()!;

                        // You can then retrieve the value from the Map like this:
                        var name = data['uname'];
                      }*/
