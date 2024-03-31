import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const Live());
}

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LivePage(),
    );
  }
}

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  String? liveData;

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the fetchData() function when the page is loaded
  }

  Future<void> fetchData() async {
    final url =
        Uri.parse('https://3dcb-112-134-96-193.ngrok-free.app/api/live_data');
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
        title: const Text('Live Data'),
        backgroundColor: const Color.fromARGB(255, 216, 184, 0),
      ),
      body: Container(
        color: const Color(0xFFE1DB82),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                // height: 150, // Set desired height
                // width: 200,
                padding: const EdgeInsets.all(15),
                children: <Widget>[
                  InfoCard(
                    title: 'Inside Temperature',
                    icon: 'assets/thermometer.png',
                    value: liveData != null
                        ? 'In Temperature: ${json.decode(liveData!)['live_in_temperature'] ?? 'N/A'}°C'
                        : 'Fetching data...',
                  ),
                  InfoCard(
                    title: '     Outside\nTemperature',
                    icon: 'assets/thermometer.png',
                    value: liveData != null
                        ? 'Out Temperature: ${json.decode(liveData!)['live_out_temperature'] ?? 'N/A'}°C'
                        : 'Fetching data...',
                  ),
                  InfoCard(
                    title: 'Inside Humidity',
                    icon: 'assets/humidity.png',
                    value: liveData != null
                        ? 'In Humidity: ${json.decode(liveData!)['live_in_humidity'] ?? 'N/A'}%'
                        : 'Fetching data...',
                  ),
                  InfoCard(
                    title: 'Outside Humidity',
                    icon: 'assets/humidity.png',
                    value: liveData != null
                        ? 'Out Humidity: ${json.decode(liveData!)['live_out_humidity'] ?? 'N/A'}%'
                        : 'Fetching data...',
                  ),
                  InfoCard(
                    title: 'Frequency',
                    icon: 'assets/frequency.png',
                    value: liveData != null
                        ? 'Frequency: ${json.decode(liveData!)['live_frequency'] ?? 'N/A'}Hz'
                        : 'Fetching data...',
                  ),
                  InfoCard(
                    title: 'Weight',
                    icon: 'assets/pressure-gauge.png',
                    value: liveData != null
                        ? 'Weight: ${json.decode(liveData!)['live_weight'] ?? 'N/A'}Kg'
                        : 'Fetching data...',
                  ),
                  InfoCard(
                    title: 'CO2',
                    icon: 'assets/gas.png',
                    value: liveData != null
                        ? 'CO2: ${json.decode(liveData!)['live_co'] ?? 'N/A'}ppm'
                        : 'Fetching data...',
                  ),
                  InfoCard(
                    title: 'Rainfall',
                    icon: 'assets/rain.png',
                    value: liveData != null
                        ? 'Rainfall: ${json.decode(liveData!)['live_rain'] ?? 'N/A'}'
                        : 'Fetching data...',
                  ),
                  // Other InfoCard widgets...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String icon;
  final String value;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              icon,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
