import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/temperature_data.dart';
import '../models/humidity_data.dart';
import '../models/frequency_data.dart';
import '../utils/constants.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../../login_page.dart';
import '../widgets/timely_chart_mutiple.dart';
import '../widgets/timely_chart_single.dart';

class TimeAnalysis extends StatefulWidget {
  const TimeAnalysis({super.key});

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
        'https://901f-112-134-96-252.ngrok-free.app/api/timely_data'));
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

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Analysis'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImage, // Adjust the path according to your image location
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TimeChartWidget( // Use the new widget here
                  title: "Temperature Analysis",
                  insideData: insideTempData,
                  outsideData: outsideTempData,
                ),
                TimeChartWidget( // Use the new widget here
                  title: "Humidity Analysis",
                  insideData: insideHumData,
                  outsideData: outsideHumData,
                ),
                SingleTimeChartWidget(
                  title: "Frequency Analysis",
                  Data: freqData
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabSelected: (index) {
          if (index == 1) {
            logout(context);
          }
        },
      ),
    );
  }
}
