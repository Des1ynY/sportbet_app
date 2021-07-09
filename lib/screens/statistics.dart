import 'package:betting_tips/widgets/forecast.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/appbar.dart';
import '/widgets/drawer.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: mainColor,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            CustomAppBar(label: 'СТАТИСТИКА'),
            DraggableScrollableSheet(
              initialChildSize:
                  (getScaffoldSize(context) - 140) / getScaffoldSize(context),
              minChildSize:
                  (getScaffoldSize(context) - 140) / getScaffoldSize(context),
              maxChildSize: 1,
              builder: (context, scrollControl) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: ListView.builder(
                    controller: scrollControl,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return ForecastTile(
                        icon: Icons.sports_soccer_rounded,
                        matchDate: DateTime.now().toIso8601String(),
                        winner: 0,
                        team1: 'Paris Sen Germen',
                        team2: 'Nantes',
                        league: 'France League 1',
                      );
                    },
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
