import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDB {
  static CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');

  static addUser(Map<String, dynamic> userInfo) async {
    await _ref.doc(userInfo['email']).set(userInfo, SetOptions(merge: true));
  }
}
