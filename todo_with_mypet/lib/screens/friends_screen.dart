import 'package:flutter/material.dart';

class FriendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendScreen();
  }
}

class _FriendScreen extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
      ),
    );
  }
}