import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_pet/function/AppUser.dart';

class CheckToDo {
  final FirebaseStorage _imgstorage = FirebaseStorage.instance;
  final AppUser _appUser = AppUser();

  static void showCheckToDoDialog(BuildContext context, String todoId, Function onComplete) {
    final checkToDo = CheckToDo();

    File? _image;

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

  Future<void> uploadPhoto(File file, String todoId) async {
    try {
      String userId = _appUser.userID;

      final ref = _imgstorage.ref().child('todos').child(userId).child(todoId).child('photo.jpg');
      await ref.putFile(file);
      final photoUrl = await ref.getDownloadURL();

      DocumentReference docRef = _appUser.todosCollectionRef.doc(todoId);
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
