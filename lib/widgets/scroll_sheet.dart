import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/widgets/forecasts_builder.dart';
import '/data/funcs.dart';

class DraggableForecasts extends StatefulWidget {
  const DraggableForecasts({
    required this.stream,
    required this.isVipForecast,
    Key? key,
  }) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  final bool isVipForecast;

  @override
  _DraggableForecastsState createState() => _DraggableForecastsState();
}

class _DraggableForecastsState extends State<DraggableForecasts> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: getPos(),
      minChildSize: getPos(),
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
          child: ForecastsBuilder(
            stream: widget.stream,
            controller: scrollControl,
            isVipForecast: widget.isVipForecast,
          ),
        );
      },
    );
  }

  double getPos() =>
      (getScaffoldSize(context) - 140) / getScaffoldSize(context);
}
