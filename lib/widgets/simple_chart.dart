import 'package:flutter/material.dart';
import 'package:yahoo_finances/models/stock_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimpleChart extends StatelessWidget {
  final List<ActiveData> data;

  SimpleChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ActiveData, DateTime>> series = [
      charts.Series(
        id: "ActiveChart",
        data: data,
        domainFn: (ActiveData series, _) => series.date,
        measureFn: (ActiveData sales, _) => sales.openValue,
      )
    ];
    return charts.TimeSeriesChart(
      series,
      animate: true,
    );
  }
}
