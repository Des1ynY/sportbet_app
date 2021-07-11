import 'package:flutter/material.dart';

import '/data/theme.dart';
import '/data/funcs.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    required this.label,
    required this.stats,
  });

  final String label;
  final bool stats;

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
                  child: RawMaterialButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    child: Image.asset('assets/logo_white.png'),
                  ),
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
                'Все',
                'Футбол',
                'Большой теннис',
              ]
                  .map(
                    (val) => Container(
                      margin: EdgeInsets.only(left: 5, top: 10, right: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: RawMaterialButton(
                        constraints:
                            BoxConstraints(minWidth: 10, maxHeight: 15),
                        onPressed: () {
                          setState(() {
                            widget.stats
                                ? currentFilterStats = val
                                : currentFilterVIP = val;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            border: widget.stats
                                ? currentFilterStats == val
                                    ? Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 2),
                                      )
                                    : null
                                : currentFilterVIP == val
                                    ? Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 2),
                                      )
                                    : null,
                          ),
                          child: Text(
                            val,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: widget.stats
                                  ? currentFilterStats == val
                                      ? FontWeight.bold
                                      : FontWeight.normal
                                  : currentFilterVIP == val
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
