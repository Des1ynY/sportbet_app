import 'package:flutter/material.dart';

import '/data/theme.dart';
import '/data/app_state.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    required this.label,
    required this.vip,
  });

  final String label;
  final bool vip;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: mainColor,
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  child: Image.asset('assets/logo_white.png'),
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 55,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                FilterIndicator(label: 'Все', vip: widget.vip),
                FilterIndicator(label: 'Футбол', vip: widget.vip),
                FilterIndicator(label: 'Теннис', vip: widget.vip),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterIndicator extends StatefulWidget {
  const FilterIndicator({
    required this.label,
    required this.vip,
    Key? key,
  }) : super(key: key);

  final String label;
  final bool vip;

  @override
  _FilterIndicatorState createState() => _FilterIndicatorState();
}

class _FilterIndicatorState extends State<FilterIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7, top: 10, right: 7),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: !widget.vip
              ? currentFilterStats == widget.label
                  ? Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    )
                  : null
              : currentFilterVIP == widget.label
                  ? Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    )
                  : null,
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: !widget.vip
                ? currentFilterStats == widget.label
                    ? FontWeight.bold
                    : FontWeight.normal
                : currentFilterVIP == widget.label
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
