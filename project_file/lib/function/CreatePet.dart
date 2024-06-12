import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_pet/function/AppUser.dart';
import 'package:todo_pet/screen/PetScreen.dart';

class CreatePet extends StatefulWidget {
  final AppUser appUser;

  CreatePet({required this.appUser});

  @override
  _CreatePetState createState() => _CreatePetState();
}

class _CreatePetState extends State<CreatePet> {
  final TextEditingController _petNameController = TextEditingController();

  Future<void> createPet() async {
    String petName = _petNameController.text;
    if (petName.isEmpty) {
      // 이름이 비어 있는 경우
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('펫 이름을 입력해주세요.')),
      );
      return;
    }

    // Firestore에 펫 데이터 추가
    await widget.appUser.petsCollectionRef.doc('petId').set({
      'name': petName,
      // 다른 필요한 필드 추가
    });

    // isPet 값을 true로 업데이트
    await widget.appUser.petsCollectionRef.doc('isPet').set({'isPet': true});

    // 펫 생성 완료 후 PetScreen으로 돌아가기
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PetScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Pet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _petNameController,
              decoration: InputDecoration(labelText: '펫 이름'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: createPet,
              child: Text('펫 생성하기'),
            ),
          ],
        ),
      ),
    );
  }
}
