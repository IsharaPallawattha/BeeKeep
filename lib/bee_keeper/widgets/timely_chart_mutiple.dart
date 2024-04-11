// time_chart_widget.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../models/temperature_data.dart';
import '../models/humidity_data.dart';

class TimeChartWidget extends StatelessWidget {
  final String title;
  final List<dynamic> insideData;
  final List<dynamic> outsideData;

  const TimeChartWidget({
    super.key,
    required this.title,
    required this.insideData,
    required this.outsideData,
  });

  @override
  Widget build(BuildContext context) {
    if (insideData.isEmpty || outsideData.isEmpty) {
      return const Text('No data available');
    }

    DateTime minDate = insideData.map((item) => item.dateTime).reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime maxDate = insideData.map((item) => item.dateTime).reduce((value, element) => value.isAfter(element) ? value : element);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: DateTimeAxis(
          minimum: minDate,
          maximum: maxDate,
          intervalType: DateTimeIntervalType.auto,
          dateFormat: DateFormat('MM/dd/yyyy\nhh:mm a'),
          labelRotation: -45,
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
        ),
        title: ChartTitle(text: title),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          LineSeries<dynamic, DateTime>(
            dataSource: insideData,
            xValueMapper: (dynamic item, _) => item.dateTime,
            yValueMapper: (dynamic item, _) {
              if (item is TemperatureData) {
                return item.temperature;
              } else if (item is HumData) {
                return item.humidity;
              }
              return 0;
            },
            name: 'Inside',
            color: Colors.blue.withOpacity(0.7),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          LineSeries<dynamic, DateTime>(
            dataSource: outsideData,
            xValueMapper: (dynamic item, _) => item.dateTime,
            yValueMapper: (dynamic item, _) {
              if (item is TemperatureData) {
                return item.temperature;
              } else if (item is HumData) {
                return item.humidity;
              }
              return 0;
            },
            name: 'Outside',
            color: const Color.fromARGB(255, 248, 146, 48),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
