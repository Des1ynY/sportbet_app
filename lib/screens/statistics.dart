import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/appbar.dart';
import '/widgets/drawer.dart';
import '/services/database.dart';
import '/widgets/scroll_sheet.dart';
import '/widgets/open_drawer_button.dart';

PageController statsController = PageController();

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late Stream<QuerySnapshot<Map<String, dynamic>>>? statsForecastsDB;
  late Stream<QuerySnapshot<Map<String, dynamic>>>? statsFootballDB;
  late Stream<QuerySnapshot<Map<String, dynamic>>>? statsTennisDB;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getForecasts();
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: mainColor,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            CustomAppBar(label: 'СТАТИСТИКА', vip: false),
            isLoaded
                ? PageView(
                    onPageChanged: (index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            currentFilterStats = 'Все';
                            break;
                          case 1:
                            currentFilterStats = 'Футбол';
                            break;
                          case 2:
                            currentFilterStats = 'Теннис';
                            break;
                        }
                      });
                    },
                    controller: statsController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      DraggableForecasts(
                        stream: statsForecastsDB,
                        isVipForecast: false,
                      ),
                      DraggableForecasts(
                        stream: statsFootballDB,
                        isVipForecast: false,
                      ),
                      DraggableForecasts(
                        stream: statsTennisDB,
                        isVipForecast: false,
                      ),
                    ],
                  )
                : Container(),
            Positioned(
              bottom: 10,
              right: 10,
              child: OpenDrawerButton(),
            ),
          ],
        ),
      ),
    );
  }

  getForecasts() async {
    statsForecastsDB = await ForecastsDB.getAllForecasts(vip: false);
    statsFootballDB =
        await ForecastsDB.getSportsForecasts(vip: false, filter: 'Футбол');
    statsTennisDB =
        await ForecastsDB.getSportsForecasts(vip: false, filter: 'Теннис');
    setState(() => isLoaded = true);
  }
}
