import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hi Liyanage !'),
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
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Apiary',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Location: Bandarawela',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Details'),
                            style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 152, 188, 8),
                            ),
                          ),
                          SizedBox(width: 16),
                          TextButton(
                            onPressed: () {},
                            child: Text('Hives'),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 71, 134, 186),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Apiary',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Location: Kurunegala',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Details'),
                            style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 152, 188, 8),
                            ),
                          ),
                          SizedBox(width: 16),
                          TextButton(
                            onPressed: () {},
                            child: Text('Hives'),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 71, 134, 186),
                            ),
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
          items: [
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
          unselectedItemColor: Color.fromARGB(255, 44, 43, 43),
          onTap: (int index) {
            // Handle navigation to the corresponding tab
          },
        ),
      ),
    );
  }
}
