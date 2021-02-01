import 'package:flutter/material.dart';
import 'package:footiebank/components/controls/gridDashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392850),
      body: Column(
        children: <Widget>[
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
                      "Footbase",
                      style: TextStyle(
                        fontFamily: 'georgia',
                          color: Colors.purple[300],
                          fontSize: 35,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home Menu",
                      style: TextStyle(
                          color: Colors.teal[200],
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(Icons.logout),
                  color: Colors.red,
                  onPressed: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard(),
        ],
      ),
    );
  }
}
