import 'package:flutter/material.dart';
import 'package:todo_with_mypet/screens/friends_screen.dart';
import 'package:todo_with_mypet/screens/pet_screen.dart';
import 'package:todo_with_mypet/screens/todo_screen.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: Text('To-Do List'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ToDoScreen()));
            },
          ),
          ListTile(
            title: Text('My Pet'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyPetScreen()));
            },
          ),
          ListTile(
            title: Text('Friends'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => FriendScreen()));
            },
          ),
        ],
      ),
    );
  }
}