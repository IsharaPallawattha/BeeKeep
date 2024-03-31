import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_screen.dart';
import 'login_page.dart';

class Apiaries extends StatelessWidget {
  final String userId; // Add userId parameter

  const Apiaries({super.key, required this.userId});

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void navigateToHives(BuildContext context, String apiaryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Hives(apiaryId: apiaryId, userId: userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Apiary')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final apiariesData = snapshot.data!.docs;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Hi Liyanage !'),
              backgroundColor: Color.fromARGB(255, 216, 184, 0),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.yellow,
              child: Center(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: apiariesData.length,
                  itemBuilder: (context, index) {
                    final apiary =
                        apiariesData[index].data()! as Map<String, dynamic>;
                    return Container(
                      margin: const EdgeInsets.all(20),
                      // width: 10,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 230, 230, 230),
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
                                  navigateToHives(
                                      context, apiariesData[index].id);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    71,
                                    134,
                                    186,
                                  ),
                                  foregroundColor: Colors.white,
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
              backgroundColor: Color.fromARGB(255, 216, 184, 0),
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
