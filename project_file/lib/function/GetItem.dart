import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetItem {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userID;

  GetItem(this.userID);

  //초기값
  Future<void> initItem() async {
    DocumentReference itemDoc = _firestore.collection('item').doc(userID);
    await itemDoc.set({
      'foodItem': 0,
      'toyItem': 0,
    });
  }

  //get
  Future<int> getFoodItem() async {
    DocumentSnapshot petDoc =
    await _firestore.collection('item').doc(userID).get();
    return petDoc['foodItem'];
  }

  Future<int> getToyItem() async {
    DocumentSnapshot petDoc =
    await _firestore.collection('item').doc(userID).get();
    return petDoc['toyItem'];
  }

  //set
  Future<void> setFoodItem(int newValue) async {
    await _firestore.collection('item').doc(userID).update({
      'foodItem': newValue,
    });
  }

  Future<void> setToyItem(int newValue) async {
    await _firestore.collection('item').doc(userID).update({
      'toyItem': newValue,
    });
  }
}