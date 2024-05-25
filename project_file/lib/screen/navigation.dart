import 'package:flutter/material.dart';
import 'package:todo_pet/screen/todo.dart';
import 'package:todo_pet/screen/friend.dart';
import 'package:todo_pet/screen/pet.dart';

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