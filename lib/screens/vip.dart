import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/appbar.dart';
import '/widgets/drawer.dart';
import '/widgets/forecast.dart';

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
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            CustomAppBar(label: 'VIP ПРОГНОЗ', stats: false),
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
                    itemCount: forecasts.length,
                    controller: scrollControl,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      switch (currentFilterVIP) {
                        case 'Все':
                          return forecasts[index];
                        case 'Футбол':
                          return forecasts[index].sport == 'Футбол'
                              ? forecasts[index]
                              : Container();
                        case 'Большой теннис':
                          return forecasts[index].sport == 'Теннис'
                              ? forecasts[index]
                              : Container();
                        default:
                          return Container();
                      }
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

List<ForecastTile> forecasts = [
  ForecastTile(
    sport: 'Футбол',
    matchDate: DateTime.now().toIso8601String(),
    winner: 0,
    team1: 'Paris SG',
    team2: 'Nantes',
    league: 'France League 1',
    coef: 1.5,
    predicted: true,
    forecast: 'Goals over 1.5',
  ),
  ForecastTile(
    sport: 'Теннис',
    matchDate: DateTime.now().toIso8601String(),
    winner: 0,
    team1: 'Paris SG',
    team2: 'Nantes',
    league: 'France League 1',
    coef: 1.5,
    predicted: true,
    forecast: 'Goals over 1.5',
  ),
  ForecastTile(
    sport: 'Теннис',
    matchDate: DateTime.now().toIso8601String(),
    winner: 1,
    team1: 'Paris SG',
    team2: 'Nantes',
    league: 'France League 1',
    coef: 1.5,
    predicted: false,
    forecast: 'Goals over 1.5',
  ),
  ForecastTile(
    sport: 'Футбол',
    matchDate: DateTime.now().toIso8601String(),
    winner: 0,
    team1: 'Paris SG',
    team2: 'Nantes',
    league: 'France League 1',
    coef: 1.5,
    predicted: true,
    forecast: 'Goals over 1.5',
  ),
  ForecastTile(
    sport: 'Теннис',
    matchDate: DateTime.now().toIso8601String(),
    winner: 0,
    team1: 'Paris SG',
    team2: 'Nantes',
    league: 'France League 1',
    coef: 1.5,
    predicted: true,
    forecast: 'Goals over 1.5',
  ),
  ForecastTile(
    sport: 'Футбол',
    matchDate: DateTime.now().toIso8601String(),
    winner: 0,
    team1: 'Paris SG',
    team2: 'Nantes',
    league: 'France League 1',
    coef: 1.5,
    predicted: false,
    forecast: 'Goals over 1.5',
  ),
];
