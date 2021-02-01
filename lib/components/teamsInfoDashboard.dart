import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footiebank/components/views/teamPlayers.dart';

class TeamsInfoDashboard extends StatefulWidget {
  final DocumentSnapshot post;
  TeamsInfoDashboard({
    this.post,
  });
  @override
  _TeamsInfoDashboardState createState() => _TeamsInfoDashboardState();
}

class _TeamsInfoDashboardState extends State<TeamsInfoDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff392850),
        body: Column(children: <Widget>[
          SizedBox(
            height: 120,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.post.data()['team name'].toString().toUpperCase() +
                          "'S" +
                          " INFO",
                      style: TextStyle(
                          fontFamily: 'georgia',
                          color: Colors.purple[300],
                          fontSize: 35,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
              child: GridView.count(
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: [
                //Team Info
                InkResponse(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => TeamProfile()));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TeamPlayers()));
                          },
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "Team Info",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                //View Players
                InkResponse(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamPlayers(
                                  post: widget.post,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.person_add),
                          iconSize: 70,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TeamPlayers(
                                          post: widget.post,
                                        )));
                          },
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "Players",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ]));
  }
}

commentedOut() {
  // InkResponse(
  //   onTap: () {
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => PlayerTransfer()));
  //   },
  //   child: Container(
  //     decoration: BoxDecoration(
  //         color: Colors.yellow[900],
  //         borderRadius: BorderRadius.circular(10)),
  //     child: Column(
  //       children: <Widget>[
  //         IconButton(
  //           icon: Icon(Icons.transfer_within_a_station),
  //           iconSize: 70,
  //           color: Colors.white,
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => PlayerTransfer()));
  //           },
  //         ),
  //         SizedBox(
  //           height: 14,
  //         ),
  //         Text(
  //           item3.title,
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600),
  //         ),
  //       ],
  //     ),
  //   ),
  // ),
  // //View Players
  // InkResponse(
  //   onTap: () {
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => TeamsInfo()));
  //   },
  //   child: Container(
  //     decoration: BoxDecoration(
  //         color: Colors.black54,
  //         borderRadius: BorderRadius.circular(10)),
  //     child: Column(
  //       children: <Widget>[
  //         IconButton(
  //           icon: Icon(Icons.flag),
  //           iconSize: 70,
  //           color: Colors.white,
  //           onPressed: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => TeamsInfo()));
  //           },
  //         ),
  //         SizedBox(
  //           height: 14,
  //         ),
  //         Text(
  //           item4.title,
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600),
  //         ),
  //       ],
  //     ),
  //   ),
  // ),
}
