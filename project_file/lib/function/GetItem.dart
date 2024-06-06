import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetItem {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userID;

  GetItem(this.userID);

  //초기값
  Future<void> initItem() async {
    DocumentReference itemDoc = _firestore.collection('item').doc(userID);
    DocumentSnapshot docSnapshot = await itemDoc.get();
    if(!docSnapshot.exists) {
      await itemDoc.set({
        'foodItem': 0,
        'toyItem': 0,
      });
    }
  }

  //get
  Future<int> getFoodItem() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('item').doc(userID).get();
    return itemDoc['foodItem'];
  }

  Future<int> getToyItem() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('item').doc(userID).get();
    return itemDoc['toyItem'];
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

  //receive
  Future<void> receiveItem() async {
    int currentFoodItem = await getFoodItem();
    int currentToyItem = await getToyItem();

    int newFoodItem = currentFoodItem + 1;
    int newToyItem = currentToyItem + 1;

    await _firestore.collection('item').doc(userID).update({
      'foodItem': newFoodItem,
      'toyItem': newToyItem,
    });
  }
}