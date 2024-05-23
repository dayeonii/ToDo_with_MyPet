import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestScreen();
  }
}

class _RequestScreen extends State<StatefulWidget> {
  final List<Map<String, String>> friends = [
    {"name": "친구 1", "image": "assets/images/profileIcon.png"},
    {"name": "친구 2", "image": "assets/images/profileIcon.png"},
    {"name": "친구 3", "image": "assets/images/profileIcon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends Request'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 30), child: TextField(),),
          Divider(),
          Expanded(
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(friends[index]["image"]!),
                    ),
                    title: Text(friends[index]["name"]!),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}