import 'package:flutter/material.dart';

import '/data/theme.dart';

class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(40),
        color: mainColor,
      ),
      child: RawMaterialButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        constraints: BoxConstraints(minHeight: 0, minWidth: 0),
        child: Icon(Icons.menu, color: Colors.white, size: 30),
      ),
    );
  }
}
