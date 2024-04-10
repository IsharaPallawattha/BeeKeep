// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_application_2/login_page.dart';

import 'add_hive.dart';
import 'service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_2/admin/user.dart' as user_page;

class Hives extends StatefulWidget {
  final String userId, apiaryId;
  const Hives({Key? key, required this.userId, required this.apiaryId})
      : super(key: key);

  @override
  State<Hives> createState() => _HivesState();
}

class _HivesState extends State<Hives> {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Keycontroller = TextEditingController();

  Stream? Hivestream;

  getontoeload() async {
    Hivestream =
        await DatabaseMethods().getHiveDetails(widget.userId, widget.apiaryId);
    setState(() {});
  }

  @override
  void initState() {
    getontoeload();
    super.initState();
  }

  Widget allApiaryDetails() {
    return StreamBuilder(
        stream: Hivestream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            String documentId = ds.id;
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 255, 213, 79),
                                        Color.fromARGB(255, 255, 152, 0),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name: " + ds["name"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.visible,
                                            ),
                                            SizedBox(height: 10.0),
                                            Text(
                                              "Key: " + ds["key"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20.0),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              EditHiveDetails(widget.userId,
                                                  widget.apiaryId, documentId);
                                              Namecontroller.text = ds["name"];
                                              Keycontroller.text = ds["key"];
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 30.0,
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          GestureDetector(
                                            onTap: () async {
                                              await DatabaseMethods()
                                                  .deleteHiveDetails(
                                                      widget.userId,
                                                      widget.apiaryId,
                                                      documentId);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 30.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Hive(
                userId: widget.userId,
                apiaryId: widget.apiaryId,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 255, 152, 0),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hives",
              style: TextStyle(
                color: Color.fromARGB(255, 204, 101, 32),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: <Widget>[
    IconButton(
      icon: Icon(Icons.logout),
      onPressed: () async {
         await FirebaseAuth.instance.signOut();
         Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => LoginPage()),);
      },
    ),
  ],
        backgroundColor: Color.fromARGB(255, 253, 224, 71),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: allApiaryDetails()),
          ],
        ),
      ),
    );
  }

  Future EditHiveDetails(String userID, String apiaryID, String hiveID) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel, color: Colors.orange),
                      ),
                      SizedBox(width: 60.0),
                      Text(
                        "Edit",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 213, 79),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Details",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 152, 0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(70, 255, 213, 79),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: TextField(
                      controller: Namecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Key",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(70, 255, 213, 79),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: TextField(
                      controller: Keycontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfo = {
                          "name": Namecontroller.text,
                          "key": Keycontroller.text,
                        };
                        await DatabaseMethods()
                            .updateHiveDetails(
                                userID, apiaryID, hiveID, updateInfo)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Update"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 152, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
