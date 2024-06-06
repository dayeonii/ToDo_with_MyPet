import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_pet/function/GetItem.dart';
import 'package:todo_pet/function/PetStatement.dart';

class Interactionpet {
  final PetStatement _petStatement;
  final GetItem _getItem;
  Interactionpet(this._petStatement, this._getItem);

  //먹이주기 버튼을 누르면 먹이 아이템 1 감소, 배고픔 수치 10 증가
  Future<void> feedPet() async {
    int currentFoodItem = await _getItem.getFoodItem();
    if(currentFoodItem>0) {
      int currentHungryLevel = await _petStatement.getHungryLevel();
      await _getItem.setFoodItem(currentFoodItem-1);
      await _petStatement.setHungryLevel(currentHungryLevel+10);
    }
  }

  //놀아주기 버튼을 누르면 장난감 아이템 1 감소, 심심함 수치 10 증가
  Future<void> playPet() async {
    int currentToyItem = await _getItem.getToyItem();
    if(currentToyItem>0) {
      int currentBoredLevel = await _petStatement.getBoredLevel();
      await _getItem.setToyItem(currentToyItem-1);
      await _petStatement.setBoredLevel(currentBoredLevel+10);
    }
  }

}