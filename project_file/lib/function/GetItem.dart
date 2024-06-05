import 'package:cloud_firestore/cloud_firestore.dart';

class GetItem {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userID;

  // 사용자의 음식 아이템과 장난감 아이템을 변수로 선언
  int _foodItem = 0;
  int _toyItem = 0;

  GetItem(this.userID);

  // Firestore에서 사용자의 음식 아이템 수를 가져오는 메서드
  Future<int> getFoodItem() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userID).get();
      if (userDoc.exists) {
        _foodItem = userDoc.get('foodItem') ?? 0;
        return _foodItem;
      } else {
        throw Exception('User document does not exist');
      }
    } catch (e) {
      print('Error getting food item: $e');
      throw Exception('Failed to get food item');
    }
  }

  // Firestore에서 사용자의 장난감 아이템 수를 가져오는 메서드
  Future<int> getToyItem() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userID).get();
      if (userDoc.exists) {
        _toyItem = userDoc.get('toyItem') ?? 0;
        return _toyItem;
      } else {
        throw Exception('User document does not exist');
      }
    } catch (e) {
      print('Error getting toy item: $e');
      throw Exception('Failed to get toy item');
    }
  }

  // Firestore에 사용자의 음식 아이템 수를 설정하는 메서드
  Future<void> setFoodItem(int num) async {
    try {
      await _firestore.collection('users').doc(userID).update({
        'foodItem': num,
      });
      _foodItem = num;
    } catch (e) {
      print('Error setting food item: $e');
      throw Exception('Failed to set food item');
    }
  }

  // Firestore에 사용자의 장난감 아이템 수를 설정하는 메서드
  Future<void> setToyItem(int num) async {
    try {
      await _firestore.collection('users').doc(userID).update({
        'toyItem': num,
      });
      _toyItem = num;
    } catch (e) {
      print('Error setting toy item: $e');
      throw Exception('Failed to set toy item');
    }
  }
}