import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CheckToDo {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 인증 사진 업로드 팝업을 표시하는 함수
  static void showCheckToDoDialog(BuildContext context, String todoId, Function onComplete) {
    final checkToDo = CheckToDo(); // CheckToDo 인스턴스 생성

    File? _image;

    // 이미지 선택 함수
    Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    }

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
                  await checkToDo.uploadPhoto(_image!, todoId);
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

  // 사진을 Firebase Storage에 업로드하는 함수
  Future<void> uploadPhoto(File file, String todoId) async {
    try {
      await _storage.ref('todos/$todoId').putFile(file);
    } catch (e) {
      print('Failed to upload photo: $e');
    }
  }
}
