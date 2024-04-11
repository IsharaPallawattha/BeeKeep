import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../../login_page.dart';
import '../widgets/health_card_widget.dart';
import '../widgets/feed_card_widget.dart';
import '../widgets/swarm_card_widget.dart';
import '../widgets/harvest_card_widget.dart';

class DashboardPage extends StatefulWidget {
  final String hiveKey;
  const DashboardPage({super.key, required this.hiveKey});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> prediction = [];
  double? avgFreqVal;
  double? avgHarvestVal;
  double? avgRainVal;

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.hiveKey.toString());
  }

  Future<void> fetchData(data) async {
    final response = await http.get(
        Uri.parse(
            'https://901f-112-134-96-252.ngrok-free.app/api/alerts?data=$data'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        avgFreqVal = responseData['freq'];
        avgHarvestVal = responseData['harvest'];
        avgRainVal = responseData['rain'];
        prediction = List<String>.from(responseData['prediction']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi Liyanage !'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SquareCardHarvest(
                        avgHarvestVal: avgHarvestVal,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SquareCardSwarm(
                        avgFreqVal: avgFreqVal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SquareCardFeed(
                          avgRainVal: avgRainVal
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SquareCardHealth(
                        prediction: prediction,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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









