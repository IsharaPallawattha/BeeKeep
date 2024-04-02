import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TimeAnalysis extends StatefulWidget {
  const TimeAnalysis({Key? key}) : super(key: key);

  @override
  State<TimeAnalysis> createState() => _TimeAnalysisState();
}

class _TimeAnalysisState extends State<TimeAnalysis> {
  List<TemperatureData> insideTempData = [];
  List<TemperatureData> outsideTempData = [];
  List<HumData> insideHumData = [];
  List<HumData> outsideHumData = [];
  List<FreqData> freqData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://cf7b-112-134-114-167.ngrok-free.app/api/timely_data'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      setState(() {
        insideTempData = responseData.map((item) {
          int unixTimestamp = int.parse(item['timestamp']);
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
          double temperature = double.parse(item['inside_temperature']);
          return TemperatureData(dateTime, temperature);
        }).toList();

        outsideTempData = responseData.map((item) {
          int unixTimestamp = int.parse(item['timestamp']);
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
          double temperature = double.parse(item['outside_temperature']);
          return TemperatureData(dateTime, temperature);
        }).toList();

        insideHumData = responseData.map((item) {
          int unixTimestamp = int.parse(item['timestamp']);
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
          double humidity = double.parse(item['inside_humidity']);
          return HumData(dateTime, humidity);
        }).toList();

        outsideHumData = responseData.map((item) {
          int unixTimestamp = int.parse(item['timestamp']);
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
          double humidity = double.parse(item['outside_humidity']);
          return HumData(dateTime, humidity);
        }).toList();

        freqData = responseData.map((item) {
          int unixTimestamp = int.parse(item['timestamp']);
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
          double frequency = double.parse(item['frequency']);
          return FreqData(dateTime, frequency);
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Analysis'),
        backgroundColor: const Color.fromARGB(255, 242, 207, 13),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.jpg', // Adjust the path according to your image location
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildChart("Temperature Analysis", insideTempData, outsideTempData),
                _buildChart("Humidity Analysis", insideHumData, outsideHumData),
                _buildChartSingle("Frequency Analysis", freqData),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255,242,207,13),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log out',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 242, 255, 242),
        unselectedItemColor: const Color.fromARGB(255, 44, 43, 43),
        onTap: (int index) {
          if (index == 1) {
            // Implement your logout logic here
          }
        },
      ),
    );
  }

  Widget _buildChart(String title, List<dynamic> insideData, List<dynamic> outsideData) {
    if (insideData.isEmpty || outsideData.isEmpty) {
      return Text('No data available');
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
        legend: Legend(isVisible: true),
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
            dataLabelSettings: DataLabelSettings(isVisible: true),
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
            color: Color.fromARGB(
                255, 248, 146, 48),
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

Widget _buildChartSingle(String title, List<dynamic> Data) {
  if (Data.isEmpty) {
    return Text('No data available');
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
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        LineSeries<dynamic, DateTime>(
          dataSource: Data,
          xValueMapper: (dynamic item, _) => item.dateTime,
          yValueMapper: (dynamic item, _) => item.freq,
          name: 'Frequency',
          color: Color.fromARGB(
              255, 248, 146, 48),
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    ),
  );
}


class TemperatureData {
  final DateTime dateTime;
  final double temperature;

  TemperatureData(this.dateTime, this.temperature);
}

class HumData {
  final DateTime dateTime;
  final double humidity;

  HumData(this.dateTime, this.humidity);
}
class FreqData {
  final DateTime dateTime;
  final double freq;

  FreqData(this.dateTime, this.freq);
}
