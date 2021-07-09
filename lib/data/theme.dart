import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

Color mainColor = Color(0xff3955B6);
Color header = Color(0xff233884);
Color hint = Color(0xff999999);

class Area extends StatefulWidget {
  const Area({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _AreaState createState() => _AreaState();
}

class _AreaState extends State<Area> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
        child: widget.child, color: Theme.of(context).scaffoldBackgroundColor);
  }
}

class NoGlowScrollEffect extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
