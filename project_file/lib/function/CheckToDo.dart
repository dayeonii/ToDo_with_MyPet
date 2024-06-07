import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CheckToDo {
  // Firebase 인스턴스 객체
  final FirebaseStorage _imgstorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 인증 사진 업로드 팝업을 표시하는 함수
  static void showCheckToDoDialog(BuildContext context, String userId, String todoId, Function onComplete) {
    final checkToDo = CheckToDo(); // CheckToDo 인스턴스 생성

    File? _image;

    // 사진 선택 함수
    Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    }

    // 사진 선택 팝업창
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Complete ToDo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please upload a photo as proof of completion.'),
              ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                },
                child: Text('Upload Photo'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Complete'),
              onPressed: () async {
                if (_image != null) {
                  await checkToDo.uploadPhoto(userId, _image!, todoId);
                  onComplete();
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 사진을 Firebase Storage에 업로드하는 함수, URL 저장
  Future<void> uploadPhoto(String userId, File file, String todoId) async {
    try {
      // Storage에 사진 업로드
      final ref = _imgstorage.ref().child('todos').child(userId).child(todoId).child('photo.jpg');
      await ref.putFile(file);
      final photoUrl = await ref.getDownloadURL();

      // Firestore에 사진 URL 업데이트 (문서가 존재하는지 확인)
      DocumentReference docRef = _firestore.collection('USER').doc(userId).collection('ToDos').doc(todoId);
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({
          'photoUrl': photoUrl,
          'isCompleted': true,
        });
      } else {
        print('No document to update: $docRef');
      }
    } catch (e) {
      print('Failed to upload photo: $e');
    }
  }
}