




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelSelectionScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Level'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Level 1'),
            onTap: () {
              // Navigate to the game screen with selected level
              // Navigator.push(
              //   // context,
              //   // MaterialPageRoute(builder: (context) => GameScreen(level: 1)),
              // );
            },
          ),
          // Add more levels here...
        ],
      ),
    );
  }
}