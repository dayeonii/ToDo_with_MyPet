import 'package:flutter/material.dart';
import 'package:todo_pet/screen/RequestScreen.dart';
import 'package:todo_pet/screen/NavigationScreen.dart';
import 'package:todo_pet/function/Friend.dart';

class FriendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendScreenState();
  }
}

class _FriendScreenState extends State<FriendScreen> {
  final FriendRepository friendRepository = FriendRepository();
  List<Friend> displayedFriends = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedFriends = friendRepository.getFriends();
  }

  void searchFriends(String query) {
    setState(() {
      displayedFriends = friendRepository.searchFriends(query);
    });
  }

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
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Friends',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    searchFriends(value);
                  },
                ),
              ),
              Divider(),  // 구분선
              Expanded(
                child: ListView.builder(
                  itemCount: displayedFriends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(displayedFriends[index].image),
                      ),
                      title: Text(displayedFriends[index].name),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}