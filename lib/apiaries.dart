import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'login_page.dart';

class Apiaries extends StatelessWidget {
  const Apiaries({Key? key});

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample data representing apiaries (replace with your Firestore retrieval logic)
    final apiariesData = [
      {"name": "Apiary 1", "location": "Bandarawela"},
      {"name": "Apiary 2", "location": "Kurunegala"},
      // Add more apiaries as needed
    ];

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
            child: ListView.builder(
              itemCount: apiariesData.length,
              itemBuilder: (context, index) {
                final apiary = apiariesData[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   // apiary['name'],
                      //   style: const TextStyle(fontSize: 24),
                      // ),
                      const SizedBox(height: 16),
                      Text(
                        'Location: ${apiary['location']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Implement your logic for apiary details
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                152,
                                188,
                                8,
                              ),
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
                              backgroundColor: const Color.fromARGB(
                                255,
                                71,
                                134,
                                186,
                              ),
                            ),
                            child: const Text('Hives'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
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
      ),
    );
  }
}
