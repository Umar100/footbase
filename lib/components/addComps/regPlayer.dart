import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:path/path.dart' as p;

import '../../homePage.dart';

class RegPlayer extends StatefulWidget {
  final DocumentSnapshot post;
  RegPlayer({
    this.post,
  });
  @override
  _RegPlayerState createState() => _RegPlayerState();
}

class _RegPlayerState extends State<RegPlayer> {
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  File _image;

  String _pname, _nname;
  var color = Color(0xff392850);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          title: Text(
            "Register a Player",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 80,
                    child: ClipOval(
                        child: SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image != null)
                                ? Image.file(_image)
                                : Image.network(""))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera,
                      color: color,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: TextField(
                    style: TextStyle(color: Colors.brown[900]),
                    decoration: InputDecoration(
                        labelText: "Enter Player Name",
                        labelStyle: TextStyle(color: Colors.brown[200])),
                    onChanged: (String val) {
                      this._pname = val;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: TextField(
                    style: TextStyle(color: Colors.brown[900]),
                    decoration: InputDecoration(
                        labelText: "Enter Nickname",
                        labelStyle: TextStyle(color: Colors.brown[200])),
                    onChanged: (String val) {
                      this._nname = val;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Color(0xff392850),
                  textColor: Colors.white,
                  child: Text("Register Player"),
                  onPressed: () {
                    uploadImage().whenComplete(() {
                      regPlayer(this._pname, widget.post.data()['team name'],
                          dUrl, this._nname);
                    });
                  },
                  elevation: 4.0,
                  splashColor: Colors.white,
                )
              ],
            ),
          ]),
        ));
  }

  void regPlayer(String pn, String tn, String imgurl, String nickname) async {
    try {
      await Firebase.initializeApp();
      DocumentReference dr = FirebaseFirestore.instance
          .collection("players")
          .doc(pn.toUpperCase());

      //get the document id
      final sn = await dr.get();

      //Check if the player Exists
      if (sn.exists) {
        //If it does, show this
        Flushbar(
          title: "Failed".toUpperCase(),
          message: "Player already registered".toUpperCase(),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red[900],
          borderColor: Colors.black,
        )..show(context);
      } else {
        //Add if it does not, add it to the list
        Map<String, dynamic> entries = {
          "player name": pn.toUpperCase(),
          "team name": widget.post.data()['team name'].toString().toUpperCase(),
          "imgurl": imgurl,
          "nickname": nickname.toUpperCase(),
          "searchText": setSearchParam(_pname.toLowerCase()),
        };
        dr.set(entries).whenComplete(() {
          //Show this when adding the addition succeedsF
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => HomePage()));

          Flushbar(
            title: "Success".toUpperCase(),
            message: "Player Registered Successfully!".toUpperCase(),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.blue,
            borderColor: Colors.white,
          )..show(context);
        });
      }
    } catch (ex) {
      Flushbar(
        title: "Failure".toUpperCase(),
        message: ex.message.toUpperCase(),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
        borderColor: Colors.white,
      )..show(context);
    }
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  String dUrl;

  Future getImage() async {
    // ignore: deprecated_member_use
    var img = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);

    _image = img;
  }

  Future<void> uploadImage() async {
    // ignore: unused_local_variable
    String fileName = p.basename(_image.path);
    StorageReference fsref = FirebaseStorage.instance.ref().child(_pname);
    StorageUploadTask uploadTask = fsref.putFile(_image);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    dUrl = dowurl.toString();
  }
}
