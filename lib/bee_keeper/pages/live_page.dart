import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/info_hexagon.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../../login_page.dart';
import '../utils/constants.dart';

class LivePage extends StatefulWidget {
  final String hiveKey;
  const LivePage({super.key, required this.hiveKey});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  String? liveData;

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.hiveKey.toString()); // Call the fetchData() function when the page is loaded
  }

  Future<void> fetchData(String data) async {
    final url = Uri.parse('https://901f-112-134-96-252.ngrok-free.app/api/live_data?data=$data');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          liveData = json.encode(jsonData); // Convert JSON to string
        });
      } else {
        print('Failed to fetch data. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bee Box'),
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
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  InfoHexagon(
                    title: 'Inside Temperature',
                    icon: 'assets/thermometer.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_in_temperature'] ?? 'N/A'}°C'
                        : 'Fetching data...',
                  ),
                  InfoHexagon(
                    title: 'Outside Temperature',
                    icon: 'assets/thermometer.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_out_temperature'] ?? 'N/A'}°C'
                        : 'Fetching data...',
                  ),
                  InfoHexagon(
                    title: 'Inside Humidity',
                    icon: 'assets/humidity.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_in_humidity'] ?? 'N/A'}%'
                        : 'Fetching data...',
                  ),
                  InfoHexagon(
                    title: 'Outside Humidity',
                    icon: 'assets/humidity.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_out_humidity'] ?? 'N/A'}%'
                        : 'Fetching data...',
                  ),
                  InfoHexagon(
                    title: 'Frequency',
                    icon: 'assets/frequency.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_frequency'] ?? 'N/A'}Hz'
                        : 'Fetching data...',
                  ),
                  InfoHexagon(
                    title: 'Weight',
                    icon: 'assets/pressure-gauge.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_weight'] ?? 'N/A'}Kg'
                        : 'Fetching data...',
                  ),
                  InfoHexagon(
                    title: 'CO2',
                    icon: 'assets/gas.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_co'] ?? 'N/A'}ppm'
                        : 'Fetching data...',
                  ),
                  InfoHexagon(
                    title: 'Rainfall',
                    icon: 'assets/rain.png',
                    value: liveData != null
                        ? '${json.decode(liveData!)['live_rain'] ?? 'N/A'}'
                        : 'Fetching data...',
                  ),
                  // Other InfoHexagon widgets...
                ],
              ),
            ),
          ],
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
