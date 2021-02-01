import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../teamsInfoDashboard.dart';


class TeamsInfo extends StatefulWidget {
  @override
  _TeamsInfoState createState() => _TeamsInfoState();
}

class _TeamsInfoState extends State<TeamsInfo> {
  bool isSearching = false;
  var color = Color(0xff392850);

  @override
  void initState() {
    super.initState();
  }

 

  String searchString;

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TeamsInfoDashboard(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.green,
                  Colors.blueGrey,
                  Colors.black,
                ])),
          ),
          title: !isSearching
              ? Center(
                  child: Text(
                  "Teams",
                  style: TextStyle(color: Colors.white),
                ))
              : TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Maggi United, Flower FC, Dutse Madrid etc...",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (text) {
                    setState(() {
                      searchString = text.toLowerCase();
                    });
                  }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  this.isSearching = !this.isSearching;
                });
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: (searchString == null || searchString.trim() == '')
              ? FirebaseFirestore.instance.collection("teams").snapshots()
              : FirebaseFirestore.instance
                  .collection("teams")
                  .where('searchText', arrayContains: searchString)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Huston, we've got a problem: ${snapshot.error}");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SizedBox(
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  )),
                );
              case ConnectionState.none:
                return SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                )));
              case ConnectionState.done:
                return SizedBox(
                    child: Center(
                        child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.grey,
                )));
                break;
              default:
                return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot ds) {
                  return new ListTile(
                    title: Text(
                      ds['team name'],
                      style: TextStyle(color: color),
                    ),
                    subtitle: Text(
                      ds['Region'].toString(),
                      style: TextStyle(color: color),
                    ),
                    onTap: () => navigateToDetail(ds),
                  );
                }).toList());
            }
          },
        ));
  }
}
