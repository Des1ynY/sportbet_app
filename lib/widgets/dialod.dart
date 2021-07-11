import 'package:flutter/material.dart';

import '/data/funcs.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({required this.data, Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        height: getScaffoldSize(context) * 0.6,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Center(
              child: Column(
                children: [
                  Text(
                    data['team1'],
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Text(
                    data['team2'],
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ListView(
              shrinkWrap: true,
              children: [
                field(0, data['sport']),
                field(1, data['league']),
                field(2, data['date']),
                field(3, data['winner']),
                field(4, data['forecast']),
                field(5, data['coef']),
                field(6, data['predicted']),
              ],
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Закрыть',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget field(int index, dynamic value) {
    String fieldName = '';
    String fieldValue = '';

    switch (index) {
      case 0:
        fieldName = 'Вид спорта: ';
        fieldValue = data['sport'].toString();
        break;
      case 1:
        fieldName = 'Лига: ';
        fieldValue = data['league'].toString();
        break;
      case 2:
        fieldName = 'Дата матча: ';
        fieldValue = getFormattedDate(data['date']);
        break;

      case 3:
        fieldName = 'Победитель: ';
        fieldValue = data['winner'] == 0 ? data['team1'] : data['team2'];
        break;
      case 4:
        fieldName = 'Прогноз на матч: ';
        fieldValue = data['forecast'].toString();
        break;
      case 5:
        fieldName = 'Коэффициент ставки: ';
        fieldValue = data['coef'].toString();
        break;
      case 6:
        fieldName = 'Результат: ';
        fieldValue = data['predicted'] ? 'Ставка сыграла' : 'Ставка не сыграла';
        break;
    }

    return RichText(
      text: TextSpan(
        text: fieldName,
        style: TextStyle(
          fontSize: 18,
          color: Color(0xff9498A1),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: fieldValue,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
