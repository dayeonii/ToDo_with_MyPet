import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_pet/function/CheckToDo.dart';
import 'package:todo_pet/function/AppUser.dart';

class ToDoManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AppUser _appUser = AppUser();

  List<Map<String, dynamic>> todoList = [];
  double progressRate = 0.0;

  ToDoManager() {
    _loadToDos();
  }

  // 현재 로그인한 사용자의 userID 가져오기
  String getUserID() {
    return _auth.currentUser!.uid;
  }

  // Firebase에 저장된 해당 사용자의 ToDos 하위 컬렉션에 접근
  CollectionReference getUserToDos() {
    return _appUser.todosCollectionRef;
  }

  // 로컬 투두 리스트에 서버의 내용 불러와 저장하기
  Future<void> _loadToDos() async {
    try {
      final QuerySnapshot result = await getUserToDos().get();
      final List<DocumentSnapshot> documents = result.docs;
      todoList = documents.map((doc) => {
        'id': doc.id,
        'title': doc['title'],
        'isCompleted': doc['isCompleted'],
        'timestamp': doc['timestamp']
      }).toList();
      _renewProgressRate();
      //print('Loaded ${todoList.length} todos');
    } catch (e) {
      //print('Error loading todos: $e');
    }
  }

  void _renewProgressRate() {
    int completedToDos = todoList.where((todo) => todo['isCompleted'] == true).length;
    progressRate = todoList.isEmpty ? 0.0 : (completedToDos / todoList.length) * 100;
  }

  Future<void> addToDo(String title) async {
    try {
      final newToDo = {
        'title': title,
        'isCompleted': false,
        'timestamp': FieldValue.serverTimestamp(),
      };

      DocumentReference docRef = await getUserToDos().add(newToDo);
      newToDo['id'] = docRef.id;
      todoList.add(newToDo);
      _renewProgressRate();
      //print('Added todo: $title');
    } catch (e) {
      //print('Error adding todo: $e');
    }
  }

  Future<void> deleteToDo(String id) async {
    try {
      await getUserToDos().doc(id).delete();
      todoList.removeWhere((todo) => todo['id'] == id);
      _renewProgressRate();
      //print('Deleted todo with id: $id');
    } catch (e) {
      //print('Error deleting todo: $e');
    }
  }

  Future<void> completeToDo(String id) async {
    try {
      await getUserToDos().doc(id).update({'isCompleted': true});
      int index = todoList.indexWhere((todo) => todo['id'] == id);
      if (index != -1) {
        todoList[index]['isCompleted'] = true;
      }
      _renewProgressRate();

      //print('Completed todo with id: $id');
    } catch (e) {
      //print('Error completing todo: $e');
    }
  }

  void checkToDo(BuildContext context, String todoId, VoidCallback onComplete) {
    CheckToDo.showCheckToDoDialog(context, todoId, () async {
      await completeToDo(todoId);
      onComplete();
    });
  }

  Future<List<Map<String, dynamic>>> getToDoList() async {
    await _loadToDos();
    return todoList;
  }

  Stream<QuerySnapshot> getTodosStream() {
    return getUserToDos().orderBy('timestamp', descending: true).snapshots();
  }

  Future<double> calculateProgressRate() async {
    await _loadToDos();
    int completedCount = todoList.where((todo) => todo['isCompleted'] == true).length;
    return todoList.isEmpty ? 0.0 : (completedCount / todoList.length) * 100;
  }
}
