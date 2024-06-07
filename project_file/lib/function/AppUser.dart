import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _userID;
  late DocumentReference _userDocRef;

  // 싱글톤 인스턴스
  static final AppUser _instance = AppUser._internal();

  factory AppUser() {
    return _instance;
  }

  AppUser._internal() {
    _userID = _auth.currentUser!.uid;
    _userDocRef = _firestore.collection('USER').doc(_userID);
  }

  // 현재 사용자의 UID 가져오기
  String get userID => _userID;

  // 현재 사용자의 ToDos 컬렉션 가져오기
  CollectionReference get todosCollectionRef => _userDocRef.collection('ToDos');

  // 현재 사용자의 Items 컬렉션 가져오기
  CollectionReference get itemsCollectionRef => _userDocRef.collection('Item');

  // 현재 사용자의 Pets 컬렉션 가져오기
  CollectionReference get petsCollectionRef => _userDocRef.collection('Pet');

  // 현재 사용자의 정보를 다시 불러오기
  Future<void> reloadUser() async {
    _userID = _auth.currentUser!.uid;
    _userDocRef = _firestore.collection('USER').doc(_userID);
  }
}