import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/appbar.dart';
import '/widgets/drawer.dart';

class VIP extends StatefulWidget {
  const VIP({Key? key}) : super(key: key);

  @override
  _VIPState createState() => _VIPState();
}

class _VIPState extends State<VIP> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: mainColor,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            CustomAppBar(label: 'VIP ПРОГНОЗ'),
            DraggableScrollableSheet(
              initialChildSize:
                  (getScaffoldSize(context) - 140) / getScaffoldSize(context),
              minChildSize:
                  (getScaffoldSize(context) - 140) / getScaffoldSize(context),
              maxChildSize: 1,
              builder: (context, scrollControl) {
                return SingleChildScrollView(
                  controller: scrollControl,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    height: 1000,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
