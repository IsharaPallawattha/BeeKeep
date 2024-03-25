import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').doc('U001').collection('Apiary').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final apiariesData = snapshot.data!.docs;

          return Scaffold(
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
                    final apiary = apiariesData[index].data()! as Map<String, dynamic>;
                    return Container(
                      margin: const EdgeInsets.all(20),
                      // width: 10,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            apiary['name'] as String,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Location: ${apiary['location']}',
                            style: const TextStyle(fontSize: 15),
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
          );
        }
      },
    );
  }
}
