import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(Live());
}

class Live extends StatefulWidget {
  const Live({Key? key}) : super(key: key);

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LivePage(),
    );
  }
}

class LivePage extends StatefulWidget {
  const LivePage({Key? key}) : super(key: key);

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
    final url = Uri.parse('https://cf7b-112-134-114-167.ngrok-free.app/api/live_data');
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
        title: const Text('Hi Liyanage !'),
        backgroundColor: const Color.fromARGB(255,242,207,13),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/comb.jpg"),
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
            logout(context);
          }
        },
      ),
    );
  }

  void logout(BuildContext context) {
    // Implement your logout logic here
    Navigator.of(context).pop(); // For simplicity, just close the current screen
  }
}

class InfoHexagon extends StatelessWidget {
  final String title;
  final String icon;
  final String value;

  const InfoHexagon({
    Key? key,
    required this.title,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Adjust margins as needed
      child: ClipPath(
        clipper: HexagonClipper(),
        child: Container(
          color: const Color.fromARGB(220, 248, 146, 48), // Set the background color with alpha value (opacity)
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    Path path = Path();
    path.moveTo(width / 4, 0);
    path.lineTo(width * 3 / 4, 0);
    path.lineTo(width, height / 2);
    path.lineTo(width * 3 / 4, height);
    path.lineTo(width / 4, height);
    path.lineTo(0, height / 2);
    path.lineTo(width / 4, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
