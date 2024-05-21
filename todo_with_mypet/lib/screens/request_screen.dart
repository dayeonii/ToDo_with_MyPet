import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestScreen();
  }
}

class _RequestScreen extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends Request'),
        centerTitle: true,
      ),
    );
  }
}