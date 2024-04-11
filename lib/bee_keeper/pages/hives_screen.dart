import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';
import '../models/hive.dart';
import '../service/firebase_service.dart';
import '../../login_page.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/hive_buttons_row.dart'; // Import the HiveButtonsRow widget

class HiveScreen extends StatelessWidget {
  final String userId;
  final String apairyId;

  const HiveScreen({super.key, required this.userId,required this.apairyId});

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeeBox'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseService.getHiveStream(userId, apairyId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final hivesData = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: hivesData.length,
                  itemBuilder: (context, index) {
                    final hive = hivesData[index].data()! as Map<String, dynamic>;
                    final hiveObject = Hive(
                      name: hive['name'] as String,
                      key: hive['key'] as String,
                    );
                    return Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
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
                          const CircleAvatar(
                            backgroundColor: accentColor,
                            radius: 40,
                            backgroundImage: AssetImage(apiaryImage),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            hiveObject.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Key: ${hiveObject.key}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          HiveButtonsRow(hiveKey: hiveObject.key), // Use the HiveButtonsRow widget here
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabSelected: (index) {
          if (index == 1) {
            logout(context);
          }
        },
      ),
    );
  }
}
