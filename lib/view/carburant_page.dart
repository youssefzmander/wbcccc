

import 'package:flutter/material.dart';

class Carburant_page extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Carburant:', style: TextStyle(fontSize: 20)),
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