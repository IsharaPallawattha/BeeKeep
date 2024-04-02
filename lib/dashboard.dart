import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> prediction = [];
  double? avgFreqVal;
  double? avgHarvestVal;
  double? avgRainVal;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://cf7b-112-134-114-167.ngrok-free.app/api/alerts'));
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
        backgroundColor: const Color.fromARGB(255, 242, 207, 13),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'),
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
                      child: _buildSquareCardHarvest(),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildSquareCardSwarm(),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildSquareCardFeed(),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildSquareCardHealth(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 242, 207, 13),
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

  Widget _buildSquareCardSwarm() {
    String? imagePath;
    String? title;
    Color? col;
    if (avgFreqVal != null) {
      if (avgFreqVal! > 400) {
        imagePath = 'assets/alert.png';
        title = 'Swarming Detected';
        col = Color.fromARGB(
            255, 248, 146, 48);
      } else {
        imagePath = 'assets/check.png';
        title = "No Swarming Detected";
        col = Colors.green;
      }
    } else {
      imagePath = 'assets/oops.png';
      title = 'Sorry, Couldn\'t Load Data';
      col = Colors.red;
    }
    return _createCard(imagePath!, title!, col!);
  }

  Widget _buildSquareCardHarvest() {
    String? imagePath;
    String? title;
    Color? col;
    if (avgHarvestVal != null) {
      if (avgHarvestVal! >= 14.00) {
        imagePath = 'assets/alert.png';
        title = 'Ready to Harvest';
        col = Color.fromARGB(
            255, 248, 146, 48);
      } else {
        imagePath = 'assets/check.png';
        title = "Not Ready to Harvest";
        col = Colors.green;
      }
    } else {
      imagePath = 'assets/oops.png';
      title = 'Sorry, Couldn\'t Load Data';
      col = Colors.red;
    }
    return _createCard(imagePath!, title!, col!);
  }

  Widget _buildSquareCardHealth() {
    String? imagePath;
    String? title;
    Color? col;
    if (prediction.isNotEmpty) {
      String result = prediction[0];
      if (result == "Unhealthy") {
        imagePath = 'assets/alert.png';
        title = 'Unhealthy Hive';
        col = Color.fromARGB(
            255, 248, 146, 48);
      } else if (result == "Healthy") {
        imagePath = 'assets/check.png';
        title = 'Healthy Hive';
        col = Colors.green;
      }
    } else {
      imagePath = 'assets/oops.png';
      title = 'Sorry, Couldn\'t Load Data';
      col = Colors.red;
    }
    return _createCard(imagePath!, title!, col!);
  }

  Widget _buildSquareCardFeed() {
    String? imagePath;
    String? title;
    Color? col;
    if (avgRainVal != null) {
      if (avgRainVal! >= 50) {
        imagePath = 'assets/alert.png';
        title = 'Feeding Required';
        col = Color.fromARGB(
            255, 248, 146, 48);
      } else {
        imagePath = 'assets/check.png';
        title = "No Feeding Required";
        col = Colors.green;
      }
    } else {
      imagePath = 'assets/oops.png';
      title = 'Sorry, Couldn\'t Load Data';
      col = Colors.red;
    }
    return _createCard(imagePath!, title!, col!);
  }

  Widget _createCard(String path, String title, Color col) {
    return SizedBox(
      width: 160.0,
      height: 160.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: Image.asset(path),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: col,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
