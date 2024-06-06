import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  final String petID;

  Users({required this.uid, required this.petID});

  factory Users.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Users(
      uid: doc.id, // Firebase Authentication의 UID를 문서ID로 사용
      petID: data['petID'] ?? '',
    );
  }
}