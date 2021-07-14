import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

import '/widgets/scroll_sheet.dart';
import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/appbar.dart';
import '/widgets/drawer.dart';
import '/services/database.dart';
import '/widgets/open_drawer_button.dart';

PageController vipController = PageController();

class VIP extends StatefulWidget {
  const VIP({Key? key}) : super(key: key);

  @override
  _VIPState createState() => _VIPState();
}

class _VIPState extends State<VIP> {
  late Stream<QuerySnapshot<Map<String, dynamic>>>? vipForecastsDB;
  late Stream<QuerySnapshot<Map<String, dynamic>>>? vipFootballDB;
  late Stream<QuerySnapshot<Map<String, dynamic>>>? vipTennisDB;
  DateTime currentDate = DateTime(2000);
  DateTime lastDate = DateTime(2000);
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
            CustomAppBar(label: 'VIP ПРОГНОЗ', vip: true),
            isLoaded
                ? PageView(
                    onPageChanged: (index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            currentFilterVIP = 'Все';
                            break;
                          case 1:
                            currentFilterVIP = 'Футбол';
                            break;
                          case 2:
                            currentFilterVIP = 'Теннис';
                            break;
                        }
                      });
                    },
                    controller: vipController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      DraggableForecasts(
                        stream: vipForecastsDB,
                        isVipForecast: true,
                      ),
                      DraggableForecasts(
                        stream: vipFootballDB,
                        isVipForecast: true,
                      ),
                      DraggableForecasts(
                        stream: vipTennisDB,
                        isVipForecast: true,
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
    vipForecastsDB = await ForecastsDB.getAllForecasts(vip: true);
    vipFootballDB = await ForecastsDB.getSportsForecasts(
      vip: true,
      filter: 'Футбол',
    );
    vipTennisDB = await ForecastsDB.getSportsForecasts(
      vip: true,
      filter: 'Теннис',
    );
    setState(() => isLoaded = true);
  }
}
