import 'package:flutter/material.dart';

import '/data/theme.dart';

class Logo extends StatelessWidget {
  const Logo({required this.label, Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          child: Image.asset('assets/logo.png'),
        ),
        Text(
          label,
          style: TextStyle(
            color: mainColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
