
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';

class SingleTimeChartWidget extends StatelessWidget {
  final String title;
  final List<dynamic> Data;

  const SingleTimeChartWidget({
    super.key,
    required this.title,
    required this.Data,

  });

  @override
  Widget build(BuildContext context) {
    if (Data.isEmpty) {
      return const Text('No data available');
    }

    DateTime minDate = Data.map((item) => item.dateTime).reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime maxDate = Data.map((item) => item.dateTime).reduce((value, element) => value.isAfter(element) ? value : element);

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
            dataSource: Data,
            xValueMapper: (dynamic item, _) => item.dateTime,
            yValueMapper: (dynamic item, _) => item.freq,
            name: 'Frequency',
            color: accentColor,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );

  }
}
