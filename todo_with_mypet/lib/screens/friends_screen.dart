import 'package:flutter/material.dart';
import 'package:todo_with_mypet/screens/request_screen.dart';
import 'package:todo_with_mypet/screens/navigation_screen.dart';

class FriendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendScreen();
  }
}

class _FriendScreen extends State<StatefulWidget> {
  //친구목록 예시
  final List<Map<String, String>> friends = [
    {"name": "친구 1", "image": "assets/images/profileIcon.png"},
    {"name": "친구 2", "image": "assets/images/profileIcon.png"},
    {"name": "친구 3", "image": "assets/images/profileIcon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationScreen(),
      appBar: AppBar(
        title: Text('Friends List'),
        centerTitle: true,
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RequestScreen()));
          }, child: Text('+'))
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 30), child: TextField(),),
              Divider(),  //구분선
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
        ),
      ),
    );
  }
}