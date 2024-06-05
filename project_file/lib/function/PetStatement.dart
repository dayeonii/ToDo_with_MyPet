import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PetStatement with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String petID;

  PetStatement(this.petID);

  //초기값
  Future<void> initPet() async {
    DocumentReference petDoc = _firestore.collection('pet').doc(petID);
    await petDoc.set({
      'hungryLevel': 0,
      'boredLevel': 0,
    });
  }

  //get
  Future<int> getHungryLevel() async {
    DocumentSnapshot petDoc =
        await _firestore.collection('pet').doc(petID).get();
    return petDoc['hungryLevel'];
  }

  Future<int> getBoredLevel() async {
    DocumentSnapshot petDoc =
        await _firestore.collection('pet').doc(petID).get();
    return petDoc['boredLevel'];
  }

  //set
  Future<void> setHungryLevel(int newValue) async {
    await _firestore.collection('pet').doc(petID).update({
      'hungryLevel': newValue,
    });
  }

  Future<void> setBoredLevel(int newValue) async {
    await _firestore.collection('pet').doc(petID).update({
      'boredLevel': newValue,
    });
  }
}
