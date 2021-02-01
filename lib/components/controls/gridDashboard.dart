import 'package:flutter/material.dart';
import 'package:footiebank/components/addComps/regTeam.dart';
import 'package:footiebank/components/views/playerRegTeamList.dart';
import 'package:footiebank/components/views/sellTeamList.dart';
import 'package:footiebank/components/views/teamsInfo.dart';
import 'package:firebase_core/firebase_core.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
    @override
  void initState() {
    super.initState();
    startFire();
  }

  startFire() async {
    await Firebase.initializeApp();
  }
  Items item1 = new Items(title: "Team Registration");
  Items item2 = new Items(title: "Player Registration");
  Items item3 = new Items(title: "Player Transfer");
  Items item4 = new Items(title: "Teams Info");

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 5),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
          //Reg Team
          InkResponse(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddTeams()));
            },
            child: Container(
              
              decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    iconSize: 70,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddTeams()));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    item1.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          //Reg Player
          InkResponse(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlayerRegTeamList()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.person_add),
                    iconSize: 70,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PlayerRegTeamList()));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    item2.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          //TransferPlayer
          InkResponse(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SellTeamList()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.transfer_within_a_station),
                    iconSize: 70,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellTeamList()));
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    item3.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          //View Teams Info
          InkResponse(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TeamsInfo()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.flag),
                    iconSize: 70,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TeamsInfo()));
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    item4.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}

class Items {
  String title;
  Icons add;
  Items({this.title});
}
