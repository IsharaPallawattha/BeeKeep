import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'live.dart';
import 'timely_analysis.dart';

class Hives extends StatefulWidget {
  final String apiaryId;
  final String userId;

  const Hives({super.key, required this.apiaryId, required this.userId});

  @override
  State<Hives> createState() => _HivesState();
}

class _HivesState extends State<Hives> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userId) // Replace 'U001' with your actual document ID
          .collection('Apiary')
          .doc(widget.apiaryId)
          .collection('Hives')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('No hives available for this apiary'));
        } else {
          final hivesData = snapshot.data!.docs;

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
                  itemCount: hivesData.length,
                  itemBuilder: (context, index) {
                    final hive =
                        hivesData[index].data()! as Map<String, dynamic>;
                    return Container(
                      margin: const EdgeInsets.all(20),
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
                            hive['name']
                                as String, // Convert integer to string before displaying
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Key: ${hive['key']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Live(),
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
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Live Data'),
                              ),
                              const SizedBox(width: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Live(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    255,
                                    165,
                                    0,
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Alerts'),
                              ),
                              const SizedBox(width: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TimeAnalysis()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    71,
                                    134,
                                    186,
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Timely'),
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
                  // Implement your logout logic here
                }
              },
            ),
          );
        }
      },
    );
  }
}
