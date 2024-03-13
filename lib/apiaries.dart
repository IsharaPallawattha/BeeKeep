import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

class Apiaries extends StatelessWidget {
  const Apiaries({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hi Liyanage !'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.yellow,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Apiary',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Location: Bandarawela',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 152, 188, 8),
                            ),
                            child: const Text('Details'),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 71, 134, 186),
                            ),
                            child: const Text('Hives'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Apiary',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Location: Kurunegala',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 152, 188, 8),
                            ),
                            child: const Text('Details'),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 71, 134, 186),
                            ),
                            child: const Text('Hives'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Apiaries',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hive),
              label: 'Hives',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Log out',
            ),
          ],
          selectedItemColor: Colors.green,
          unselectedItemColor: const Color.fromARGB(255, 44, 43, 43),
          onTap: (int index) {
            // Handle navigation to the corresponding tab
          },
        ),
      ),
    );
  }
}
