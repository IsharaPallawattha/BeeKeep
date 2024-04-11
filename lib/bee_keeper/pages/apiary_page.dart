import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';
import '../models/apiary.dart';
import '../service/firebase_service.dart';
import '../../login_page.dart';
import 'hives_screen.dart';
import '../widgets/bottom_navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  final String userId;

  const DashboardScreen({super.key, required this.userId});

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
        builder: (context) => HiveScreen(userId: userId, apairyId: apiaryId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi Liyanage !'),
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
            stream: FirebaseService.getApiaryStream(userId),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final apiariesData = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: apiariesData.length,
                  itemBuilder: (context, index) {
                    final apiary = apiariesData[index].data()! as Map<String, dynamic>;
                    final apiaryObject = Apiary(
                      name: apiary['name'] as String,
                      location: apiary['location'] as String,
                    );
                    final apiaryID = apiariesData[index].id;
                    return Container(
                      margin: const EdgeInsets.all(16),
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
                      child: Padding(
                        padding: const EdgeInsets.all(5),
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
                              apiaryObject.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Location: ${apiaryObject.location}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                navigateToHives(context, apiaryID);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              // child: Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //     vertical: 10,
                              //     horizontal: 20,
                              //   ),
                                child: const Text(
                                  'View Hives',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            // ),
                          ],
                        ),
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
