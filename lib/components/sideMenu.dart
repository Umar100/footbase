import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          child: Text("Our Head, y'all!!!"),
          decoration: BoxDecoration(color: Colors.green),
        ),
        ListTile(
          title: Text("Manage Teams"),
        )
      ])),
    );
  }
}
