import 'package:bloggie/draft.dart';
import 'package:bloggie/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bloggie/UserState.dart';
import 'package:intl/intl.dart';

class Commentui extends StatefulWidget {
  final String docid;
  const Commentui({
    Key? key,
    required this.docid,
  }) : super(key: key);
  _CommentuiState createState() => _CommentuiState();
}

String? cmnt;
final cmntController = TextEditingController();

class _CommentuiState extends State<Commentui> {
  String usersex = "MALE";
  @override
  void initState() {
    super.initState();
    Provider.of<UserState>(context, listen: false).getName();
  }

  @override
  Widget build(BuildContext context) {
    final String gen = Provider.of<UserState>(context).userGen;
    final String name = Provider.of<UserState>(context).userName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffFAFAFA),
        elevation: 2,
        leading: IconButton(
          splashRadius: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('blogs')
                .doc(widget.docid)
                .collection('comments')
                .orderBy('cmtdate')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 17.0, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(document['cmtowner'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0)),
                                Text(document['cmtdate'])
                              ],
                            ),
                            Text(
                              document['comment1'],
                            ),
                          ],
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
      bottomNavigationBar: Container(
        width: 395.4,
        height: 70.7,
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xffeae9e9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: usersex == gen
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/004/819/327/original/male-avatar-profile-icon-of-smiling-caucasian-man-vector.jpg',
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/004/819/322/original/female-avatar-woman-profile-icon-for-network-vector.jpg',
                            ),
                          ),
                  ),
                  Expanded(
                      child: TextFormField(
                    cursorColor: Color(0xff535252),
                    cursorHeight: 25.0,
                    controller: cmntController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Comment here",
                    ),
                  )),
                  InkWell(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection('blogs')
                          .doc(widget
                              .docid) // you need to enter this document id
                          .collection('comments')
                          .add({
                        'comment1': cmntController.text,
                        'cmtowner': name,
                        'cmtdate': DateFormat('dd/MM/yyyy, hh:mm')
                            .format(DateTime.now()),
                      });
                      cmntController.clear();
                    },
                    child: Icon(
                      Icons.send,
                      color: Color(0xff585454),
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
