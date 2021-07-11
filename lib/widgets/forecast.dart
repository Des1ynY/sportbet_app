import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/widgets/dialod.dart';

class ForecastTile extends StatefulWidget {
  const ForecastTile({
    required this.forecast,
    required this.sport,
    required this.matchDate,
    required this.winner,
    required this.team1,
    required this.team2,
    required this.league,
    required this.coef,
    required this.predicted,
    Key? key,
  }) : super(key: key);

  final int winner;
  final double coef;
  final bool predicted;
  final String matchDate, team1, team2, league, sport, forecast;

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
          return CustomDialog(
            data: {
              'sport': widget.sport,
              'league': widget.league,
              'date': widget.matchDate,
              'team1': widget.team1,
              'team2': widget.team2,
              'coef': widget.coef,
              'winner': widget.winner,
              'forecast': widget.forecast,
              'predicted': widget.predicted,
            },
          );
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
              width: width * 0.11,
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
                            style: widget.winner == 0
                                ? TextStyle(color: Colors.green.shade300)
                                : null,
                          ),
                          TextSpan(text: ' - '),
                          TextSpan(
                            text: widget.team2,
                            style: widget.winner == 1
                                ? TextStyle(color: Colors.green.shade300)
                                : null,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.league,
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
              width: width * 0.11,
              child: widget.predicted
                  ? Icon(
                      Icons.check,
                      color: Colors.green.shade300,
                      size: 30,
                    )
                  : Icon(
                      Icons.close,
                      color: Colors.red.shade400,
                      size: 30,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
