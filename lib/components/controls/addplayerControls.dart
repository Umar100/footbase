import 'package:flutter/material.dart';

class Addplcontr extends StatefulWidget {
  @override
  _AddplcontrState createState() => _AddplcontrState();
}

class _AddplcontrState extends State<Addplcontr> {
  String firstTeamVal;
  List<String> firstTeams = [
    'Kobi Rangers',
    'Golden Kobi Rangers',
    'Flamengo',
    'Samba Gwabba',
    'Monaco',
    'Golden Pillars',
    'Scorpion'
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            
            // children: myList.map((data) {
            children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonFormField<String>(
              value: firstTeamVal,
              icon: Icon(Icons.arrow_circle_down),
              items: firstTeams.map((t) {
                  return DropdownMenuItem(
                    child: new Text(t),
                    value: t,
                  );
              }).toList(),
              onChanged: (val) {},
            ),
                ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButtonFormField<String>(
                value: firstTeamVal,
                icon: Icon(Icons.arrow_circle_down),
                items: firstTeams.map((t) {
                  return DropdownMenuItem(
                    child: new Text(t),
                    value: t,
                  );
                }).toList(),
                onChanged: (val) {},
              ),
            ) 
          ]
         
        ));
  }
}
