import 'package:flutter/material.dart';

import '/data/theme.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({required this.label});
  final String label;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String currentFilter = 'Все';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: mainColor,
      child: Column(
        children: [
          Column(
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
          Container(
            height: 55,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                'Все',
                'Футбол',
                'Хоккей',
                'Волейбол',
                'Киберспорт',
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
                            currentFilter = val;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            border: currentFilter == val
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
                              fontWeight: currentFilter == val
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
