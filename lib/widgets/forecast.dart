import 'package:betting_tips/data/app_state.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '/data/theme.dart';
import '/icons.dart';
import '/data/funcs.dart';
import '/widgets/dialod.dart';

class ForecastTile extends StatefulWidget {
  ForecastTile(this.json) {
    team1 = json['team1'];
    team2 = json['team2'];
    matchDate = json['date'];
    sport = json['sport'];
    forecast = json['forecast'];
    coef = double.parse(json['coef']);
    predicted = json['predicted'];
    winner = json['winner'];
    league = json['league'];
  }

  final Map<String, dynamic> json;
  late final double coef;
  late final bool predicted;
  late final String matchDate, team1, team2, league, sport, forecast, winner;

  @override
  _ForecastTileState createState() => _ForecastTileState();
}

class _ForecastTileState extends State<ForecastTile> {
  Color linesColor = Color(0xff5B5C61);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return RawMaterialButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(data: widget.json);
        },
      ),
      child: Container(
        width: width,
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Color(0xffECEEF2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      widget.sport == 'Футбол'
                          ? Icons.sports_soccer
                          : Icons.sports_tennis,
                      color: linesColor,
                      size: 30),
                  Divider(
                    color: linesColor,
                    thickness: 1.5,
                  ),
                  Text(
                    formatTime(widget.matchDate),
                    style: TextStyle(
                      color: linesColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: linesColor,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          color: linesColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: widget.team1,
                            style: widget.winner == widget.team1
                                ? TextStyle(color: mainColor)
                                : null,
                          ),
                          TextSpan(text: ' - '),
                          TextSpan(
                            text: widget.team2,
                            style: widget.winner == widget.team2
                                ? TextStyle(color: mainColor)
                                : null,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.league,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: linesColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: linesColor,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            Container(
              width: 50,
              child: widget.predicted
                  ? Icon(
                      CustomIcons.check_1,
                      color: mainColor,
                      size: 30,
                    )
                  : Icon(
                      CustomIcons.cancel,
                      color: linesColor.withOpacity(0.8),
                      size: 30,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class VIPForecastTile extends StatefulWidget {
  VIPForecastTile(
    this.json,
  ) {
    team1 = json['team1'];
    team2 = json['team2'];
    matchDate = json['date'];
    sport = json['sport'];
    forecast = json['forecast'];
    coef = double.parse(json['coef']);
    league = json['league'];
  }

  final Map<String, dynamic> json;
  late final double coef;
  late final String matchDate, team1, team2, league, sport, forecast;

  @override
  _VIPForecastTileState createState() => _VIPForecastTileState();
}

class _VIPForecastTileState extends State<VIPForecastTile> {
  Color linesColor = Color(0xff5B5C61);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return RawMaterialButton(
      onPressed: () async {
        if (forecasts.contains(widget.json['id'])) {
          showDialog(
            context: context,
            builder: (context) => CustomVIPDialog(data: widget.json),
          );
        } else {
          var result = await showDialog(
            context: context,
            builder: (context) {
              return OpenForecastDialog(data: widget.json);
            },
          );
          if (result && result != null) {
            showDialog(
              context: context,
              builder: (context) => CustomVIPDialog(data: widget.json),
            );
          }
        }
      },
      child: Container(
        width: width,
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Color(0xffECEEF2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      widget.sport == 'Футбол'
                          ? Icons.sports_soccer
                          : Icons.sports_tennis,
                      color: linesColor,
                      size: 30),
                  Divider(
                    color: linesColor,
                    thickness: 1.5,
                  ),
                  Text(
                    formatTime(widget.matchDate),
                    style: TextStyle(
                      color: linesColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: linesColor,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          color: linesColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: widget.team1,
                          ),
                          TextSpan(text: ' - '),
                          TextSpan(
                            text: widget.team2,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.league,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: linesColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: linesColor,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            Container(
              width: 50,
              child: Text(
                sprintf('%.02f', [widget.coef]),
                style: TextStyle(
                  fontSize: 16,
                  color: mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
