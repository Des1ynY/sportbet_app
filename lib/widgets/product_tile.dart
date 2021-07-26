import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class VIPStoreTile extends StatelessWidget {
  const VIPStoreTile({
    Key? key,
    required this.title,
    required this.cost,
    required this.onPressed,
    this.profitable = false,
  }) : super(key: key);

  final String title;
  final double cost;
  final bool profitable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xff3955B6), width: 3),
            ),
            child: MaterialButton(
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        title.replaceAll('(Betting Tips - MORENO)', ''),
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
                      sprintf('%.00f ₽', [cost]),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffE93E3E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          profitable
              ? Positioned(
                  top: 8,
                  right: -24,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(33 / 360),
                    child: Container(
                      color: Color(0xffE93E3E),
                      alignment: Alignment.center,
                      width: 100,
                      height: 20,
                      child: Text(
                        'Выгодно',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
