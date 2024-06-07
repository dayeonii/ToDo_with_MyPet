import 'package:flutter/material.dart';
import 'package:todo_pet/function/Friend.dart';

class RequestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestScreen();
  }
}

class _RequestScreen extends State<StatefulWidget> {
  final FriendRepository friendRepository = FriendRepository();
  List<Friend> requests = [];

  @override
  void initState() {
    super.initState();
    requests = friendRepository.getRequests();
  }

  @override
  void acceptRequest(Friend friend) {
    setState(() {
      friendRepository.acceptRequest(friend);
      requests = friendRepository.getRequests();
    });
  }

  @override
  void rejectRequest(Friend friend) {
    setState(() {
      friendRepository.rejectRequest(friend);
      requests = friendRepository.getRequests();
    });
  }

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
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(requests[index].image),
                    ),
                    title: Text(requests[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.circle_outlined),
                          onPressed: () {acceptRequest(requests[index]);},
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {rejectRequest(requests[index]);},
                        ),
                      ],
                    ),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}