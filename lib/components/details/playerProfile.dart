import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../homePage.dart';

class PlayerProfile extends StatefulWidget {
  final DocumentSnapshot post;
  PlayerProfile({
    this.post,
  });
  @override
  _PlayerProfileState createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  void initState() {
    super.initState();
    pnControl.text = widget.post.data()['player name'].toString();
    nickControl.text = widget.post.data()['nickname'].toString();
  }

  turnRead() {
    setState(() {
      isUpdatingQty = false;
    });
  }

  offRead() {
    setState(() {
      isUpdatingQty = true;
    });
  }

  bool isUpdatingQty = true;
  bool isUpdatingPrice = true;
  TextEditingController pnControl = new TextEditingController();
  TextEditingController nickControl = new TextEditingController();

  void updatePlayerDetail(String plN, String nikName) async {
    DocumentReference dr = FirebaseFirestore.instance
        .collection("players")
        .doc(widget.post.data()['player name']);

    Map<String, dynamic> entries = {"player name": plN, "nickname": nikName};
    dr.update(entries).whenComplete(() {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => HomePage()));

      //Show this when adding the update succeeds
      Flushbar(
        title: "Success".toUpperCase(),
        message: "Player's data Updated successfully!".toUpperCase(),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.blue,
        borderColor: Colors.white,
      )..show(context);
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = FlatButton(
      child: Text("Delete", style: TextStyle(color: Colors.red)),
      onPressed: () {
        _deleteData();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Icon(Icons.warning),
      content: Text("Are you sure you want to delete this profile?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _deleteData() async {
    var firestore = FirebaseFirestore.instance;
    await firestore
        .collection("players")
        .doc(widget.post.data()['team name'])
        .delete()
        .whenComplete(() {
      firestore
          .collection("players")
          .doc(widget.post.data()['searchText'])
          .delete()
          .whenComplete(() {
        firestore
            .collection("players")
            .doc(widget.post.data()['player name'])
            .delete()
            .whenComplete(() {
          firestore
              .collection("players")
              .doc(widget.post.data()['nickname'])
              .delete()
              .whenComplete(() {
            firestore
                .collection("players")
                .doc(widget.post.data()['imgurl'])
                .delete()
                .whenComplete(() {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
              Flushbar(
                title: "Deleted!".toUpperCase(),
                message:
                    "${widget.post.data()['product name']} deleted successfully"
                        .toUpperCase(),
                duration: Duration(seconds: 7),
                backgroundColor: Colors.red[900],
                borderColor: Colors.black,
              )..show(context).whenComplete(() {
                  Navigator.pop(context);
                });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Modify/Delete " +
                widget.post.data()['player name'] +
                "'s PROFILE"),
            actions: <Widget>[
              FlatButton(
                onPressed: (() {
                  showAlertDialog(context);
                }),
                child: Icon(Icons.delete_sharp, color: Colors.red),
              ),
            ],
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
            )),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                readOnly: isUpdatingQty,
                controller: pnControl,
                decoration: InputDecoration(
                    labelText: "Player Name",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: isUpdatingQty ? turnRead : offRead)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                readOnly: isUpdatingQty,
                controller: nickControl,
                decoration: InputDecoration(
                    labelText: "Nickname",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: isUpdatingQty ? turnRead : offRead)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: Colors.teal,
                textColor: Colors.white,
                focusColor: Colors.teal[100],
                highlightColor: Colors.teal[400],
                hoverColor: Colors.teal[700],
                child: Text("Update"),
                onPressed: () {
                  updatePlayerDetail(pnControl.text, nickControl.text);
                })
          ]),
        ));
  }
}
