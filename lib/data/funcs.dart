import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

String currentFilterStats = 'Все';
String currentFilterVIP = 'Все';

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
  return sprintf('%02d:%02d', [matchDate.hour, matchDate.hour]);
}

String getFormattedDate(String date) {
  DateTime matchDate = DateTime.parse(date);
  return sprintf('%02d.%02d.%04d %02d:%02d', [
    matchDate.day,
    matchDate.month,
    matchDate.year,
    matchDate.hour,
    matchDate.hour
  ]);
}
