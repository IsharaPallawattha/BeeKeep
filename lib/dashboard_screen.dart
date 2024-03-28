import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'live.dart';

class Hives extends StatefulWidget {
  final String apiaryId;
  final String userId;


  const Hives({Key? key, required this.apiaryId, required this.userId}) : super(key: key);

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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No hives available for this apiary'));
        } else {
          final hivesData = snapshot.data!.docs;

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
                  itemCount: hivesData.length,
                  itemBuilder: (context, index) {
                    final hive = hivesData[index].data()! as Map<String, dynamic>;
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
                            hive['name'] as String, // Convert integer to string before displaying
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
                                  // Navigate to live.dart or implement your logic
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Live(),
                                  //   ),
                                  // );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    71,
                                    134,
                                    186,
                                  ),
                                ),
                                child: const Text('Live Data'),
                              ),
                              SizedBox(width: 20),
                              TextButton(
                                onPressed: () {
                                  // Navigate to live.dart or implement your logic
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Live(),
                                  //   ),
                                  // );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    71,
                                    134,
                                    186,
                                  ),
                                ),
                                child: const Text('Timely Analysis'),
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
