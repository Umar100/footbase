import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeamPlayers extends StatefulWidget {
  final DocumentSnapshot post;
  TeamPlayers({
    this.post,
  });
  @override
  _TeamPlayersState createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  bool isSearching = false;
  var color = Color(0xff392850);
  File _image;

  @override
  void initState() {
    super.initState();
  }

  String searchString;

  navigateToDetail(DocumentSnapshot post) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => PlayerProfile(
    //               post: post,
    //             )));
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
                  "Players",
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
              ? FirebaseFirestore.instance
                  .collection("players")
                  .where('team name',
                      isEqualTo: widget.post
                          .data()['team name']
                          .toString()
                          .toUpperCase())
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("players")
                  .where('searchText', arrayContains: searchString)
                  .where('team name',
                      isEqualTo: widget.post
                          .data()['team name']
                          .toString()
                          .toUpperCase())
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
                      ds['player name'],
                      style: TextStyle(color: color),
                    ),
                    subtitle: Text(
                      ds['nickname'].toString(),
                      style: TextStyle(color: color),
                    ),
                    leading: SizedBox(
                      height: 200,
                      width: 100,
                      child: (_image != null)
                          ? Image.file(_image)
                          : Image.network(
                              ds['imgurl'],
                              fit: BoxFit.fill,
                            ),
                    ),
                    onTap: () => navigateToDetail(ds),
                  );
                }).toList());
            }
          },
        ));
  }
}
