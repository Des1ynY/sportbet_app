import 'package:flutter/material.dart';

class VIPStoreTile extends StatelessWidget {
  const VIPStoreTile({
    Key? key,
    required this.title,
    required this.cost,
    required this.onPressed,
    this.profitable = false,
  }) : super(key: key);

  final String title;
  final int cost;
  final bool profitable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xff3955B6), width: 2),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Text(
                  title,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            VerticalDivider(
              thickness: 1.5,
              color: Color(0xff9498A1),
              indent: 20,
              endIndent: 20,
            ),
            Container(
              width: 80,
              child: Text(
                '$cost ₽',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
