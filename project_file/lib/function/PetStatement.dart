import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_pet/function/AppUser.dart';

class PetStatement {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AppUser _appUser = AppUser();

  // Pet 초기화
  Future<void> initPet() async {
    try {
      DocumentReference petDocRef = _appUser.petsCollectionRef.doc(_appUser.userID);
      DocumentSnapshot petDocSnapshot = await petDocRef.get();

      if (!petDocSnapshot.exists) {
        await petDocRef.set({
          'hungryLevel': 0,
          'boredLevel': 0,
          'totalLike': 0,
        });
      }
    } catch (e) {
      print('Error initializing pet: $e');
      throw e;
    }
  }

  // 배고픔 수치 가져오기
  Future<int> getHungryLevel() async {
    try {
      DocumentSnapshot petDocSnapshot = await _appUser.petsCollectionRef.doc(_appUser.userID).get();
      return petDocSnapshot['hungryLevel'];
    } catch (e) {
      print('Error getting hungry level: $e');
      throw e;
    }
  }

  // 심심함 수치 가져오기
  Future<int> getBoredLevel() async {
    try {
      DocumentSnapshot petDocSnapshot = await _appUser.petsCollectionRef.doc(_appUser.userID).get();
      return petDocSnapshot['boredLevel'];
    } catch (e) {
      print('Error getting bored level: $e');
      throw e;
    }
  }

  // 좋아요 수 가져오기
  Future<int> getTotalLike() async {
    try {
      DocumentSnapshot petDocSnapshot = await _appUser.petsCollectionRef.doc(_appUser.userID).get();
      return petDocSnapshot['totalLike'] ?? 0;
    } catch (e) {
      print('Error getting total like: $e');
      throw e;
    }
  }

  // 배고픔 수치 설정
  Future<void> setHungryLevel(int newValue) async {
    try {
      await _appUser.petsCollectionRef.doc(_appUser.userID).update({
        'hungryLevel': newValue,
      });
    } catch (e) {
      print('Error setting hungry level: $e');
      throw e;
    }
  }

  // 심심함 수치 설정
  Future<void> setBoredLevel(int newValue) async {
    try {
      await _appUser.petsCollectionRef.doc(_appUser.userID).update({
        'boredLevel': newValue,
      });
    } catch (e) {
      print('Error setting bored level: $e');
      throw e;
    }
  }

  // 좋아요 수 설정
  Future<void> setTotalLike(int newValue) async {
    try {
      await _appUser.petsCollectionRef.doc(_appUser.userID).update({
        'totalLike': newValue,
      });
    } catch (e) {
      print('Error setting total like: $e');
      throw e;
    }
  }
}
