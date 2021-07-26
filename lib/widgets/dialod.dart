import 'package:flutter/material.dart';

import '/icons.dart';
import '/data/funcs.dart';
import '/data/theme.dart';
import '/data/app_state.dart';
import '/services/router.dart';
import '/services/database.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.data,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: getScaffoldSize(context) * 0.6,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    child: Icon(
                      data['sport'] == 'Футбол'
                          ? Icons.sports_soccer
                          : Icons.sports_tennis,
                      color: Color(0xffBFBFBF),
                      size: 60,
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          data['team1'].toString(),
                          softWrap: true,
                          style: TextStyle(
                            color: header,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      VerticalDivider(
                        width: 30,
                        color: header,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Expanded(
                        child: Text(
                          data['team2'].toString(),
                          softWrap: true,
                          style: TextStyle(
                            color: header,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getFormattedDate(data['date']),
                      style: TextStyle(
                        color: Color(0xff9498A1),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      formatTime(data['date']),
                      style: TextStyle(
                        color: Color(0xff9498A1),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      field('Лига'),
                      SizedBox(
                        height: 15,
                      ),
                      field('Счет матча'),
                      SizedBox(
                        height: 15,
                      ),
                      field('Победитель'),
                      SizedBox(
                        height: 15,
                      ),
                      field('Прогноз на матч'),
                      SizedBox(
                        height: 15,
                      ),
                      field('Коэффициент ставки'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Результат ставки: ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff9498A1),
                            ),
                          ),
                          Container(
                            height: 23,
                            child: data['predicted']
                                ? Icon(
                                    CustomIcons.check_1,
                                    color: mainColor,
                                    size: 30,
                                  )
                                : Icon(
                                    Icons.close,
                                    color: Color(0xff5B5C61).withOpacity(0.8),
                                    size: 30,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Закрыть',
                style: TextStyle(
                  color: Color(0xff179CE7),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget field(String label) {
    String fieldValue = '';

    switch (label) {
      case 'Лига':
        fieldValue = data['league'].toString();
        break;
      case 'Победитель':
        fieldValue = data['winner'];
        break;
      case 'Прогноз на матч':
        fieldValue = data['forecast'].toString();
        break;
      case 'Коэффициент ставки':
        fieldValue = data['coef'].toString();
        break;
      case 'Счет матча':
        fieldValue = '${data['team1Score']} : ${data['team2Score']}';
        break;
    }

    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: TextStyle(
          fontSize: 15,
          color: Color(0xff9498A1),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: fieldValue,
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class CustomVIPDialog extends StatelessWidget {
  const CustomVIPDialog({
    required this.data,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: getScaffoldSize(context) * 0.55,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    child: Icon(
                      data['sport'] == 'Футбол'
                          ? Icons.sports_soccer
                          : Icons.sports_tennis,
                      color: Color(0xffBFBFBF),
                      size: 60,
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          data['team1'].toString(),
                          softWrap: true,
                          style: TextStyle(
                            color: header,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      VerticalDivider(
                        width: 30,
                        color: header,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Expanded(
                        child: Text(
                          data['team2'].toString(),
                          softWrap: true,
                          style: TextStyle(
                            color: header,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getFormattedDate(data['date']),
                      style: TextStyle(
                        color: Color(0xff9498A1),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      formatTime(data['date']),
                      style: TextStyle(
                        color: Color(0xff9498A1),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      field('Лига'),
                      SizedBox(
                        height: 15,
                      ),
                      field('Прогноз на матч'),
                      SizedBox(
                        height: 15,
                      ),
                      field('Коэффициент ставки'),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Закрыть',
                style: TextStyle(
                  color: Color(0xff179CE7),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget field(String label) {
    String fieldValue = '';

    switch (label) {
      case 'Лига':
        fieldValue = data['league'].toString();
        break;
      case 'Прогноз на матч':
        fieldValue = data['forecast'].toString();
        break;
      case 'Коэффициент ставки':
        fieldValue = data['coef'].toString();
        break;
    }

    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: TextStyle(
          fontSize: 15,
          color: Color(0xff9498A1),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: fieldValue,
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class OpenForecastDialog extends StatelessWidget {
  const OpenForecastDialog({required this.data, Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: getScaffoldSize(context) * 0.47,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    child: Icon(
                      data['sport'] == 'Футбол'
                          ? Icons.sports_soccer
                          : Icons.sports_tennis,
                      color: Color(0xffBFBFBF),
                      size: 60,
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          data['team1'].toString(),
                          softWrap: true,
                          style: TextStyle(
                            color: header,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      VerticalDivider(
                        width: 30,
                        color: header,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Expanded(
                        child: Text(
                          data['team2'].toString(),
                          softWrap: true,
                          style: TextStyle(
                            color: header,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getFormattedDate(data['date']),
                      style: TextStyle(
                        color: Color(0xff9498A1),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      formatTime(data['date']),
                      style: TextStyle(
                        color: Color(0xff9498A1),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Открыть доступ к данному VIP-прогнозу?',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Оплачено VIP-прогнозов: $vipCount',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: header,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    if (vipCount > 0) {
                      vipCount -= 1;
                      forecasts.add(data['id']);
                      await UsersDB.openForecast(
                        userEmail,
                        {'forecasts': forecasts, 'vipCount': vipCount},
                      );
                      Navigator.pop(context, true);
                    } else {
                      Navigator.pop(context, false);
                      Navigator.pushNamed(context, storeRoute);
                    }
                  },
                  child: Text(
                    'Подтвердить',
                    style: TextStyle(
                      color: Color(0xff179CE7),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Отмена',
                    style: TextStyle(
                      color: Color(0xff179CE7),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
