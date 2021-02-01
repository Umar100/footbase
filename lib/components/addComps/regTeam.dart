import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';

import '../../homePage.dart';

class AddTeams extends StatefulWidget {
  @override
  _AddTeamsState createState() => _AddTeamsState();
}

class _AddTeamsState extends State<AddTeams> {
  TextEditingController tnControl = new TextEditingController();
  String regVal;
  List<String> regions = [
    'Kobi',
    'Railway',
    'Kofar Idi',
    'Jahun',
    'Dawaki',
    'Yelwa',
    'Seventh',
    'Eighth'
  ];
  var color = Color(0xff392850);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          "Team Registration",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
        ),
      ),
      body: Column(
        children: <Widget>[
          //Team's Name
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: TextField(
              style: TextStyle(color: Colors.brown[900]),
              decoration: InputDecoration(
                  labelText: "Enter Team Name",
                  labelStyle: TextStyle(color: Colors.brown[200])),
              onChanged: (val) {
                _tname = val;
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //Select Region
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Region',
                  labelStyle: TextStyle(color: Colors.brown[200])),
              value: regVal,
              icon: Icon(Icons.arrow_circle_down),
              items: regions.map((r) {
                return DropdownMenuItem(
                  child: new Text(r),
                  value: r,
                );
              }).toList(),
              onChanged: (val) {
                selectedRegion = val;
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
              color: color,
              textColor: Colors.white,
              child: Text("Register Team"),
              onPressed: () {
                regTeam(this._tname, this.selectedRegion);
              })
        ],
      ),
    );
  }

  String _tname, selectedRegion;
  void regTeam(String tn, String sr) async {
    try {
      await Firebase.initializeApp();
      DocumentReference dr =
          FirebaseFirestore.instance.collection("teams").doc('$_tname');

      //get the document id
      final sn = await dr.get();

      //Check if the team Exists
      if (sn.exists) {
        //If it does, show this
        Flushbar(
          title: "Failed".toUpperCase(),
          message: "Team already registered".toUpperCase(),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red[900],
          borderColor: Colors.black,
        )..show(context);
      } else {
        //Add if it does not, add it to the list
        Map<String, dynamic> entries = {
          "team name": tn.toUpperCase(),
          "Region": sr.toUpperCase(),
          "searchText": setSearchParam(_tname.toLowerCase()),
        };
        dr.set(entries).whenComplete(() {
          //Show this when adding the addition succeeds
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => HomePage()));

          Flushbar(
            title: "Success".toUpperCase(),
            message: "Team Registered Successfully!".toUpperCase(),
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
