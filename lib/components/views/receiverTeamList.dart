import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../homePage.dart';

class ReceiverTeamList extends StatefulWidget {
  final DocumentSnapshot post;
  ReceiverTeamList({
    this.post,
  });
  @override
  _ReceiverTeamListState createState() => _ReceiverTeamListState();
}

class _ReceiverTeamListState extends State<ReceiverTeamList> {
  bool isSearching = false;
  var color = Color(0xff392850);

  @override
  void initState() {
    super.initState();
    // getTeams();
    startFire();
  }

  startFire() async {
    await Firebase.initializeApp();
  }

  String searchString;

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
                  "Select Team to Sell From",
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
                      onTap: () => updatePlayerTeam(ds['team name']));
                }).toList());
            }
          },
        ));
  }

  void updatePlayerTeam(String team) async {
    DocumentReference dr = FirebaseFirestore.instance
        .collection("players")
        .doc(widget.post["player name"]);

    Map<String, dynamic> entries = {"team name": team.toUpperCase()};
    dr.update(entries).whenComplete(() {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => HomePage()));

      //Show this when adding the update succeeds
      Flushbar(
        title: "Success".toUpperCase(),
        message: "Player Transfered successfully!".toUpperCase(),
        duration: Duration(seconds: 4),
        backgroundColor: color,
        borderColor: Colors.white,
      )..show(context);
    });
  }
}
