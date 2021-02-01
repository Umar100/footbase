import 'package:flutter/material.dart';
import 'package:footiebank/components/views/sellTeamList.dart';




class PlayerTransfer extends StatefulWidget {
  
  @override
  _PlayerTransferState createState() => _PlayerTransferState();
}

class _PlayerTransferState extends State<PlayerTransfer> {
  
  var color = Color(0xff392850);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          title: Text(
            "Player Transfer",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        body: Column(
          
          children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SellTeamList(),
          )),
          ],
        ));
  }
}
