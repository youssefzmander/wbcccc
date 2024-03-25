

import 'package:flutter/material.dart';

class Suivi_page extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('suivi', style: TextStyle(fontSize: 20)),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.device_unknown, size: 50),
                title: Text('rien'),
                subtitle:
Text("rien"),

              ),
              
            ),
            
          ],
        ),
        
      ),
    );
  }
}