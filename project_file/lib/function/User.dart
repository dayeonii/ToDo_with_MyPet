import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String petID;

  User({required this.uid, required this.petID});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return User(
      uid: doc.id, // Firebase Authentication의 UID를 문서ID로 사용
      petID: data['petID'] ?? '',
    );
  }
}
