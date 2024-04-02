import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'live.dart';
import 'timely_analysis.dart';

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
          .doc(widget.userId)
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
            child: Text('No hives available for this apiary'),
          );
        } else {
          final hivesData = snapshot.data!.docs;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Hi Liyanage !'),
              backgroundColor: const Color.fromARGB(255,242,207,13),
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
                child: ListView.builder(
                  itemCount: hivesData.length,
                  itemBuilder: (context, index) {
                    final hive = hivesData[index].data()! as Map<String, dynamic>;
                    return Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white, // Reduced transparency
                        borderRadius: BorderRadius.circular(16),
                        // border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(255, 248, 146, 48),
                            radius: 40,
                            backgroundImage: AssetImage('assets/bee.png'),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            hive['name'] as String,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Key: ${hive['key']}',
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Live()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 3,
                                  ),
                                  child: Text(
                                    'Live',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Live()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 248, 146, 48)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 3,
                                  ),
                                  child: Text(
                                    'Alerts',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width:2),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TimeAnalysis()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 3,
                                  ),
                                  child: Text(
                                    'Time',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
