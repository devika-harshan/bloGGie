import 'package:bloggie/Commentui.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter/material.dart';

class feeddetails extends StatefulWidget {
  final String title;
  final String date;
  final String body;
  final String author;
  final String documentid;
  const feeddetails(
      {Key? key,
      required this.title,
      required this.documentid,
      required this.author,
      required this.date,
      required this.body})
      : super(key: key);

  _feeddetailsState createState() => _feeddetailsState();
}

class _feeddetailsState extends State<feeddetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Color(0xffFAFAFA),
        ),
        body: Container(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 15),
                child: Text(widget.title,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Align(
                alignment: AlignmentDirectional(-1, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.body,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (
                        context,
                      ) =>
                              Commentui(docid: widget.documentid)),
                    );
                  },
                  icon: Icon(Icons.message, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                  child: LikeButton(likeCount: 0),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
