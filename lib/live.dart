import 'package:flutter/material.dart';
import 'apiaries.dart';
import 'timely_analysis.dart';

class Live extends StatelessWidget {
  const Live({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LivePage(),
    );
  }
}

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 100, // Adjust the height as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TopPanelItem(
                  title: 'Live',
                  isSelected: true,
                  onTap: () {
                    // Do nothing as we're already in the Live page
                  },
                ),
                TopPanelItem(
                  title: 'Timely\nAnalysis',
                  onTap: () {
                    // Navigate to Timely Analysis page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => TimelyAnalysisPage()),
                    // );
                  },
                ),
                TopPanelItem(
                  title: 'Swarming\nAlerts',
                  onTap: () {
                    // Navigate to Swarming Alerts page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SwarmingAlertsPage()),
                    // );
                  },
                ),
                TopPanelItem(
                  title: 'More\nAnalysis',
                  onTap: () {
                    // Navigate to More Analysis page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => MoreAnalysisPage()),
                    // );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: const <Widget>[
                InfoCard(
                  title: 'Temperature',
                  icon: 'assets/thermometer.png',
                  value: '25°C',
                ),
                InfoCard(
                  title: 'Humidity',
                  icon: 'assets/humidity.png',
                  value: '60%',
                ),
                InfoCard(
                  title: 'Honey Amount',
                  icon: 'assets/honey.png',
                  value: '50 kg',
                ),
                InfoCard(
                  title: 'Current Frequency',
                  icon: 'assets/frequency.png',
                  value: '100 Hz',
                ),
                InfoCard(
                  title: 'Rainfall Amount',
                  icon: 'assets/rain.png',
                  value: '10 mm',
                ),
                InfoCard(
                  title: 'Wind Speed',
                  icon: 'assets/wind.png',
                  value: '20 km/h',
                ),
                InfoCard(
                  title: 'Atmospheric Pressure',
                  icon: 'assets/pressure-gauge.png',
                  value: '1013 hPa',
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                // Navigate back to the dashboard_screen page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Apiaries()),
                );
              },
              backgroundColor: Colors.blue,
              child: const Text('Home'),
            ),
          ),
        ],
      ),
    );
  }
}

class TopPanelItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TopPanelItem({
    super.key,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: isSelected ? Colors.white : Colors.blue,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 18,
              ),
            ),
          ),
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
