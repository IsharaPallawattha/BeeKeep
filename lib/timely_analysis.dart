import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TimeAnalysis extends StatefulWidget {
  const TimeAnalysis({Key? key}) : super(key: key);

  @override
  State<TimeAnalysis> createState() => _TimeAnalysisState();
}

class _TimeAnalysisState extends State<TimeAnalysis> {
  List<TemperatureData> insideTempData = [
    TemperatureData(DateTime(2022, 01, 01), 35),
    TemperatureData(DateTime(2022, 02, 01), 28),
    TemperatureData(DateTime(2022, 03, 01), 34),
    TemperatureData(DateTime(2022, 04, 01), 32),
    TemperatureData(DateTime(2022, 05, 01), 40),
  ];

  List<TemperatureData> outsideTempData = [
    TemperatureData(DateTime(2022, 01, 01), 25),
    TemperatureData(DateTime(2022, 02, 01), 22),
    TemperatureData(DateTime(2022, 03, 01), 30),
    TemperatureData(DateTime(2022, 04, 01), 28),
    TemperatureData(DateTime(2022, 05, 01), 35),
  ];

  List<HumidityData> insideHumidityData = [
    HumidityData(DateTime(2022, 01, 01), 50),
    HumidityData(DateTime(2022, 02, 01), 48),
    HumidityData(DateTime(2022, 03, 01), 52),
    HumidityData(DateTime(2022, 04, 01), 55),
    HumidityData(DateTime(2022, 05, 01), 60),
  ];

  List<HumidityData> outsideHumidityData = [
    HumidityData(DateTime(2022, 01, 01), 45),
    HumidityData(DateTime(2022, 02, 01), 42),
    HumidityData(DateTime(2022, 03, 01), 48),
    HumidityData(DateTime(2022, 04, 01), 50),
    HumidityData(DateTime(2022, 05, 01), 55),
  ];

  List<CO2LevelData> co2Data = [
    CO2LevelData(DateTime(2022, 01, 01), 400),
    CO2LevelData(DateTime(2022, 02, 01), 450),
    CO2LevelData(DateTime(2022, 03, 01), 500),
    CO2LevelData(DateTime(2022, 04, 01), 420),
    CO2LevelData(DateTime(2022, 05, 01), 480),
  ];

  List<HiveWeightData> hiveWeightData = [
    HiveWeightData(DateTime(2022, 01, 01), 50),
    HiveWeightData(DateTime(2022, 02, 01), 48),
    HiveWeightData(DateTime(2022, 03, 01), 52),
    HiveWeightData(DateTime(2022, 04, 01), 55),
    HiveWeightData(DateTime(2022, 05, 01), 60),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timely Analysis"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildChart("Temperature Analysis", insideTempData, outsideTempData),
            _buildChart("Humidity Analysis", insideHumidityData, outsideHumidityData),
            _buildChart("CO2 Level", co2Data, []),
            _buildChart("Hive Weight", hiveWeightData, []),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(String title, List<dynamic> insideData, List<dynamic> outsideData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        title: ChartTitle(text: title),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          LineSeries<dynamic, DateTime>(
            dataSource: insideData,
            xValueMapper: (dynamic item, _) => item.dateTime,
            yValueMapper: (dynamic item, _) =>
            item is TemperatureData
                ? item.temperature
                : (item is HumidityData
                ? item.humidity
                : (item is CO2LevelData ? item.co2Level : (item is HiveWeightData ? item.hiveWeight : 0))),
            name: 'Inside',
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
          if (outsideData.isNotEmpty)
            LineSeries<dynamic, DateTime>(
              dataSource: outsideData,
              xValueMapper: (dynamic item, _) => item.dateTime,
              yValueMapper: (dynamic item, _) =>
              item is TemperatureData
                  ? item.temperature
                  : (item is HumidityData
                  ? item.humidity
                  : (item is CO2LevelData ? item.co2Level : (item is HiveWeightData ? item.hiveWeight : 0))),
              name: 'Outside',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
        ],
      ),
    );
  }
}

class TemperatureData {
  final DateTime dateTime;
  final double temperature;

  TemperatureData(this.dateTime, this.temperature);
}

class HumidityData {
  final DateTime dateTime;
  final double humidity;

  HumidityData(this.dateTime, this.humidity);
}

class CO2LevelData {
  final DateTime dateTime;
  final double co2Level;

  CO2LevelData(this.dateTime, this.co2Level);
}

class HiveWeightData {
  final DateTime dateTime;
  final double hiveWeight;

  HiveWeightData(this.dateTime, this.hiveWeight);
}

