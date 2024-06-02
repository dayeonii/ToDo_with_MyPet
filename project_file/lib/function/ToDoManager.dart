import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_pet/function/CheckToDo.dart';

class ToDoManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  //firestore 인스턴스
  List<Map<String, dynamic>> todoList = []; //투두 항목들을 저장할 리스트
  double progressRate = 0.0;  //투두 달성률 수치

  ToDoManager() {
    _loadToDos();
  }

  //firestore에서 투두 항목을 로드해오는 함수
  Future<void> _loadToDos() async {
    final QuerySnapshot result = await _firestore.collection('todos').get();
    final List<DocumentSnapshot> documents = result.docs;
    todoList = documents.map((doc) => doc.data() as Map<String, dynamic>).toList();
    _renewProgressRate(); //달성률 갱신
  }

  //달성률 갱신 함수
  void _renewProgressRate() {
    int completedToDos = todoList.where((todo) => todo['isCompleted'] == true).length;
    progressRate = (completedToDos / todoList.length) * 100;
  }

  //add to-do 함수
  Future<void> addToDo(String title) async {
    final newToDo = {
      'title' : title,
      'isCompleted' : false,
      'timestamp' : FieldValue.serverTimestamp(),
    };

    DocumentReference docRef = await _firestore.collection('todos').add(newToDo);
    newToDo['id'] = docRef.id;  //firestore 문서 id를 투두 항목에 추가
    todoList.add(newToDo);  //로컬에 투두 항목 추가
    _renewProgressRate(); //달성률 갱신
  }

  //delete 함수
  Future<void> deleteToDo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
    todoList.removeWhere((todo) => todo['id'] == id); //로컬에 투두 항목 삭제
    _renewProgressRate(); //달성률 갱신
  }

  //complete 함수
  Future<void> completeToDo(String id) async {
    await _firestore.collection('todos').doc(id).update({'isCompleted': true});
    int index = todoList.indexWhere((todo) => todo['id'] == id);
    if (index != -1) {
      todoList[index]['isCompleted'] = true;  //로컬에서 완료 처리
    }
    _renewProgressRate(); //달성률 갱신
  }

  //인증사진 업로드 팝업창 띄우기 - CheckToDo 클래스 이용
  void checkToDo(String id, BuildContext context) {
    CheckToDo.showCheckToDoDialog(context, id, () async {
      await completeToDo(id); //완료처리 할 때 발생
    });
  }

  //투두리스트 반환
  Future<List<Map<String, dynamic>>> getToDoList() async {
    await _loadToDos();
    return todoList;
  }

  Stream<QuerySnapshot> getTodosStream() {
    return _firestore.collection('todos').orderBy('timestamp', descending: true).snapshots();
  }
}