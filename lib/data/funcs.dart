import 'package:betting_tips/screens/statistics.dart';
import 'package:betting_tips/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '/data/app_state.dart';

bool isValidEmail(String? value) {
  if (value != null) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  } else {
    return false;
  }
}

bool isValidPass(String? value) {
  if (value != null) {
    return value.length >= 6 ? true : false;
  } else {
    return false;
  }
}

double getScaffoldSize(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.bottom -
      MediaQuery.of(context).padding.top;
}

String formatTime(String date) {
  DateTime matchDate = DateTime.parse(date);
  return sprintf('%02d:%02d', [matchDate.hour, matchDate.minute]);
}

String getFormattedDate(String date) {
  DateTime matchDate = DateTime.parse(date);
  return sprintf('%02d.%02d.%04d', [
    matchDate.day,
    matchDate.month,
    matchDate.year,
  ]);
}

void appStateFromJson(Map<String, dynamic> json) {
  userEmail = json['email'];
  forecasts = json['forecasts'] ?? [];
  vipCount = json['vipCount'] ?? 0;
}

Map<String, dynamic> appStateToJson() {
  return {
    'email': userEmail,
    'forecasts': forecasts,
    'vipCount': vipCount,
  };
}

onStats() {
  return FutureBuilder(
    future: UsersDB.getUser(userEmail),
    builder: (
      context,
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> doc,
    ) {
      var userInfo = doc.data?.data();
      appStateFromJson(userInfo!);
      return Statistics();
    },
  );
}
