import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetItem {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userID;

  GetItem(this.userID);

  // 초기값
  Future<void> initItem() async {
    DocumentReference itemDoc = _firestore.collection('item').doc(userID);
    DocumentSnapshot docSnapshot = await itemDoc.get();
    if (!docSnapshot.exists) {
      await itemDoc.set({
        'foodItem': 0,
        'toyItem': 0,
        'firstReceive': false,
        'secondReceive': false,
      });
    }
  }

  // get
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

  Future<bool> getFirstReceive() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('item').doc(userID).get();
    return itemDoc['firstReceive'];
  }

  Future<bool> getSecondReceive() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('item').doc(userID).get();
    return itemDoc['secondReceive'];
  }

  // set
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

  Future<void> setFirstReceive(bool value) async {
    await _firestore.collection('item').doc(userID).update({
      'firstReceive': value,
    });
  }

  Future<void> setSecondReceive(bool value) async {
    await _firestore.collection('item').doc(userID).update({
      'secondReceive': value,
    });
  }

  // receive
  Future<void> receiveItem(double progressRate) async {
    bool firstReceive = await getFirstReceive();
    bool secondReceive = await getSecondReceive();

    if (progressRate >= 50 && progressRate < 99 && !firstReceive) {
      await _updateItem(3);
      await setFirstReceive(true);
    } else if (progressRate >= 99 && firstReceive && !secondReceive) {
      await _updateItem(3);
      await setSecondReceive(true);
    }
  }

  Future<void> _updateItem(int increment) async {
    int currentFoodItem = await getFoodItem();
    int currentToyItem = await getToyItem();

    await _firestore.collection('item').doc(userID).update({
      'foodItem': currentFoodItem + increment,
      'toyItem': currentToyItem + increment,
    });
  }

  // reset receive status (for new day)
  Future<void> resetReceiveStatus() async {
    await _firestore.collection('item').doc(userID).update({
      'firstReceive': false,
      'secondReceive': false,
    });
  }
}