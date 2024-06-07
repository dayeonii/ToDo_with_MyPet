import 'package:flutter/material.dart';
import 'package:todo_pet/screen/ToDoScreen.dart';
import 'package:todo_pet/screen/FriendScreen.dart';
import 'package:todo_pet/screen/PetScreen.dart';

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
                  context, MaterialPageRoute(builder: (context) => PetScreen()));
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