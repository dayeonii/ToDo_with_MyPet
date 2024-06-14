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
  String _selectedPet = '강아지'; // 사용자가 선택한 펫 종류를 저장하는 변수 (기본은 강아지)

  // 드롭다운에서 선택한 펫 종류를 저장하는 함수
  void _onPetSelected(String? value) {
    setState(() {
      _selectedPet = value ?? '강아지';
    });
  }

  Future<void> createPet() async {
    String petName = _petNameController.text;
    if (petName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('펫 이름을 입력해주세요.')),
      );
      return;
    }

    // Firestore에 펫 데이터 추가
    await widget.appUser.petsCollectionRef.doc('petId').set({
      'name': petName,
      'type': _selectedPet, // 선택한 펫 종류를 Firestore에 저장
    });

    // isPet 값을 true로 업데이트
    await widget.appUser.petsCollectionRef.doc('isPet').set({'isPet': true});

    // 펫 생성 완료 후 PetScreen으로 돌아가기
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PetScreen()),
    );
  }

  // 화면 구성
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
            DropdownButton<String>(
              value: _selectedPet,
              onChanged: _onPetSelected,
              items: <String>['강아지', '고양이', '햄스터']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
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
