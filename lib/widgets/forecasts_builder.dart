import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '/data/theme.dart';
import '/widgets/forecast.dart';

class ForecastsBuilder extends StatefulWidget {
  const ForecastsBuilder({
    required this.stream,
    required this.controller,
    required this.isVipForecast,
    Key? key,
  }) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  final ScrollController controller;
  final bool isVipForecast;

  @override
  _ForecastsBuilderState createState() => _ForecastsBuilderState();
}

class _ForecastsBuilderState extends State<ForecastsBuilder> {
  DateTime currentDate = DateTime(2000);
  DateTime lastDate = DateTime(2000);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.all(20),
                controller: widget.controller,
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var json = snapshot.data?.docs.elementAt(index).data()
                      as Map<String, dynamic>;

                  lastDate = currentDate;
                  currentDate = DateTime.parse(json['date']);

                  return widget.isVipForecast
                      ? Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (lastDate.month != currentDate.month ||
                                  lastDate.day != currentDate.day)
                                Text(
                                  'Дата - ${sprintf('%02d.%02d', [
                                        currentDate.day,
                                        currentDate.month
                                      ])}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff5B5C61),
                                    fontSize: 15,
                                  ),
                                ),
                              VIPForecastTile(json),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (lastDate.month != currentDate.month ||
                                  lastDate.day != currentDate.day)
                                Text(
                                  'Дата - ${sprintf('%02d.%02d', [
                                        currentDate.day,
                                        currentDate.month
                                      ])}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff5B5C61),
                                    fontSize: 15,
                                  ),
                                ),
                              ForecastTile(json),
                            ],
                          ),
                        );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
      },
    );
  }
}
