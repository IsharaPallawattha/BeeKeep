import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSquareCard(
                        Image.asset('assets/apiary.png'),
                        "Total Apiaries",
                        10,
                            () {
                          print("Total Apiaries card tapped!");
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildSquareCard(
                        Image.asset('assets/hive.png'),
                        "Active Hives",
                        50,
                            () {
                          print("Active Hives card tapped!");
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: _buildSquareCard(
                        Image.asset('assets/alert.png'),
                        "Harvest",
                        2,
                            () {
                          print("Total Apiaries card tapped!");
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildSquareCard(
                        Image.asset('assets/check.png'),
                        "Swarming",
                        0,
                            () {
                          print("Active Hives card tapped!");
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: _buildSquareCard(
                        Image.asset('assets/check.png',
                        ),
                        "Feeding",
                        0,
                            () {
                          print("Total Apiaries card tapped!");
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildSquareCard(
                        Image.asset('assets/alert.png'),
                        "Health Alerts",
                        0,
                            () {
                          print("Active Hives card tapped!");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquareCard(Widget icon, String title, int value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
                width: 50.0, // Specify your desired width
                height: 50.0, // Specify your desired height
                child: icon,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}