import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetItem {
  //Firebase 정보를 가져오기 위한 인스턴스 객체
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String userID;

  GetItem(this.userID);

  // 초기값
  Future<void> initItem() async {
    DocumentReference itemDoc = _firestore.collection('USER').doc(userID).collection('Items').doc('itemID');
    DocumentSnapshot docSnapshot = await itemDoc.get();
    if (!docSnapshot.exists) {
      await itemDoc.set({
        'food': 0,
        'toy': 0,
        'firstReceive': false,
        'secondReceive': false,
      });
    }
  }

  // get
  Future<int> getFoodItem() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').get();
    return itemDoc['food'];
  }

  Future<int> getToyItem() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').get();
    return itemDoc['toy'];
  }

  Future<bool> getFirstReceive() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').get();
    return itemDoc['firstReceive'];
  }

  Future<bool> getSecondReceive() async {
    DocumentSnapshot itemDoc =
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').get();
    return itemDoc['secondReceive'];
  }

  // set
  Future<void> setFoodItem(int newValue) async {
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').update({
      'food': newValue,
    });
  }

  Future<void> setToyItem(int newValue) async {
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').update({
      'toy': newValue,
    });
  }

  Future<void> setFirstReceive(bool value) async {
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').update({
      'firstReceive': value,
    });
  }

  Future<void> setSecondReceive(bool value) async {
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').update({
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
      await _updateItem(5);
      await setSecondReceive(true);
    }
  }

  Future<void> _updateItem(int increment) async {
    int currentFoodItem = await getFoodItem();
    int currentToyItem = await getToyItem();

    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').update({
      'food': currentFoodItem + increment,
      'toy': currentToyItem + increment,
    });
  }

  // reset receive status (for new day)
  Future<void> resetReceiveStatus() async {
    await _firestore.collection('USER').doc(userID).collection('Items').doc('itemID').update({
      'firstReceive': false,
      'secondReceive': false,
    });
  }
}