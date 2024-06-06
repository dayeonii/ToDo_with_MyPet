import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:todo_pet/screen/PetScreen.dart';
import 'package:todo_pet/screen/NavigationScreen.dart';
import 'package:todo_pet/function/ToDoManager.dart';
import 'package:todo_pet/function/GetItem.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToDoScreenState();
  }
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _todoController = TextEditingController();
  final ToDoManager _toDoManager = ToDoManager();
  final GetItem _getItem = GetItem('userID');

  //현재 시간
  DateTime dt = DateTime.now();
  List<String> weekdayList = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationScreen(),
      appBar: AppBar(
        title: Text('To-Do List'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyPetScreen()),
              );
            },
            child: Text('Pet'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Text(
                    '${dt.year}. ${dt.month}. ${dt.day}. ${weekdayList[dt.weekday - 1]}',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    onPressed: _addTodoDialog,
                    child: Text('+', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              width: 350.0,
              height: 1.5,
              color: Colors.black,
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _toDoManager.getToDoList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error loading todos: ${snapshot.error}');
                    return Center(child: Text('Error loading todos'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No todos available'));
                  }

                  final todoList = snapshot.data!;
                  return ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      final doc = todoList[index];
                      return _buildToDoList(doc);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: _toDoManager.progressRate / 100,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async {
                  await _getItem.receiveItem();
                  setState(() {}); // Update the screen to reflect item changes
                },
                child: Text('아이템 받기', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToDoList(Map<String, dynamic> doc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              _toDoManager.checkToDo(doc['id'], context, () {
                setState(() {});
              });
            },
            icon: Icon(
              (doc['isCompleted'] ?? false)
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
          ),
          Text(doc['title'], style: TextStyle(fontSize: 20)),
          ElevatedButton(
            onPressed: () async {
              await _toDoManager.deleteToDo(doc['id']);
              setState(() {}); // Update the screen to reflect deletion
            },
            child: Text('-', style: TextStyle(fontSize: 30)),
          ),
        ],
      ),
    );
  }

  void _addTodoDialog() {
    _todoController.clear(); //입력할 때 마다 빈 칸으로 시작

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: _todoController,
            decoration: InputDecoration(hintText: 'Enter todo here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _toDoManager.addToDo(_todoController.text);
                Navigator.of(context).pop();
                setState(() {}); // Update the screen to reflect addition
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}