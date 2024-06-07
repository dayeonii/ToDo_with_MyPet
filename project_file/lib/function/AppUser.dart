import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _userID;
  late DocumentReference _userDocRef;

  static final AppUser _instance = AppUser._internal();

  factory AppUser() {
    return _instance;
  }

  AppUser._internal() {
    if (_auth.currentUser != null) {
      _userID = _auth.currentUser!.uid;
      _userDocRef = _firestore.collection('USER').doc(_userID);
    } else {
      _userID = '';
      _userDocRef = _firestore.collection('USER').doc(); // 빈 문서 참조
    }
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

  Future<void> updateUserData() async {
    if(_auth.currentUser!=null) {
      _userID = _auth.currentUser!.uid;
      _userDocRef = _firestore.collection('USER').doc(_userID);
    }
  }

  // // 사용자 정보 초기화 -> 삭제됨
  // void clearUserData() {
  //   _userID = '';
  //   _userDocRef = _firestore.collection('USER').doc(); // 빈 문서 참조
  // }
}