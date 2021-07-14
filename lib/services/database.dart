import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDB {
  static CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');

  static addUser(Map<String, dynamic> userInfo) async {
    await _ref.doc(userInfo['email']).set(userInfo, SetOptions(merge: true));
  }
}

class ForecastsDB {
  static CollectionReference _ref =
      FirebaseFirestore.instance.collection('forecasts');

  static addForecast(Map<String, dynamic> forecastInfo) async {
    await _ref.doc(forecastInfo['id']).set(
          forecastInfo,
          SetOptions(merge: true),
        );
  }

  static getAllForecasts({required bool vip}) async {
    return _ref
        .where('vip', isEqualTo: vip)
        .orderBy('date', descending: true)
        .snapshots();
  }

  static getSportsForecasts({required bool vip, required String filter}) async {
    return _ref
        .where('vip', isEqualTo: vip)
        .where('sport', isEqualTo: filter)
        .orderBy('date', descending: true)
        .snapshots();
  }

  static deleteForecast(String id) async {
    _ref.doc(id).delete();
  }
}
