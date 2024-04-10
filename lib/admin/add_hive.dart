// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Hive extends StatefulWidget {
  final String userId;
  final String apiaryId;
  const Hive({Key? key, required this.userId, required this.apiaryId})
      : super(key: key);

  @override
  State<Hive> createState() => _HiveState();
}

class _HiveState extends State<Hive> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add",
              style: TextStyle(
                color: Color.fromARGB(255, 114, 68, 7),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Hives",
              style: TextStyle(
                color: Color.fromARGB(255, 185, 94, 19),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFA07A),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFF5EE),
              const Color(0xFFFFFACD),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Center(
                  child: Image.asset(
                    'assets/hive.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Name",
                  style: TextStyle(
                    color: const Color(0xFFA52A2A),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Key",
                  style: TextStyle(
                    color: const Color(0xFFA52A2A),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _keyController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      String HiveID = randomAlphaNumeric(10);
                      Map<String, dynamic> userInfoMap = {
                        "name": _nameController.text,
                        "key": _keyController.text,
                      };

                      bool success = await DatabaseMethods().addHiveDetails(
                          userInfoMap, widget.userId, widget.apiaryId, HiveID);

                      if (success) {
                        Fluttertoast.showToast(
                          msg: "Hive details added successfully!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xFFFFA07A),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Failed to add Hive details!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFA52A2A),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA500),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
