import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_pet/screen/PetScreen.dart';
import 'package:todo_pet/screen/NavigationScreen.dart';
import 'package:todo_pet/function/ToDoManager.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToDoScreenState();
  }
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _todoController = TextEditingController();
  // final CollectionReference _todos = FirebaseFirestore.instance.collection('todos');
  final ToDoManager _toDoManager = ToDoManager();

  /*
  Future<void> _addTodo() async {
    if (_todoController.text.isNotEmpty) {
      await _todos.add({
        'title': _todoController.text,
        'done': false,
        'timestamp': Timestamp.now(),
      });
      _todoController.clear();
    }
  }

  Future<void> _deleteTodo(String id) async {
    await _todos.doc(id).delete();
  }

  Future<void> _toggleTodoDone(DocumentSnapshot doc) async {
    await _todos.doc(doc.id).update({'done': !doc['done']});
  }
  */

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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyPetScreen()));
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
                  Text('2024. 05. 24. FRI', style: TextStyle(fontSize: 30)),
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
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final todoList = snapshot.data!;
                  return ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context,index) {
                      final dox = todoList[index];
                      return _buildToDoList(dox);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: 0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {},
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
            onPressed: () => _toDoManager.completeToDo(doc['id']),
            icon: Icon(
              //doc['done'] ? Icons.check_box : Icons.check_box_outline_blank,
                (doc['done'] ?? false) ? Icons.check_box : Icons.check_box_outline_blank, //null처리 추가
            ),
          ),
          Text(doc['title'], style: TextStyle(fontSize: 20)),
          ElevatedButton(
            onPressed: () => _toDoManager.deleteToDo(doc['id']),
            child: Text('-', style: TextStyle(fontSize: 30)),
          ),
        ],
      ),
    );
  }

  void _addTodoDialog() {
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
              onPressed: () {
                _toDoManager.addToDo(_todoController.text);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}