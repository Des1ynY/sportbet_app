import 'package:betting_tips/data/funcs.dart';
import 'package:flutter/material.dart';

class ForecastTile extends StatefulWidget {
  const ForecastTile({
    required this.icon,
    required this.matchDate,
    required this.winner,
    required this.team1,
    required this.team2,
    required this.league,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final int winner;
  final String matchDate, team1, team2, league;

  @override
  _ForecastTileState createState() => _ForecastTileState();
}

class _ForecastTileState extends State<ForecastTile> {
  Color linesColor = Color(0xff9498A1);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isOpen = false;

    return RawMaterialButton(
      onPressed: () => setState(() => isOpen = !isOpen),
      child: Container(
        width: width,
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Color(0xffF3F5FA),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: width * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, color: linesColor, size: 30),
                  Divider(
                    color: linesColor,
                    indent: 10,
                    endIndent: 10,
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
          ],
        ),
      ),
    );
  }
}
