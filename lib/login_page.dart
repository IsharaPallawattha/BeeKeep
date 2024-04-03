import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'apiaries.dart';
import 'admin/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginPage(), // Wrap LoginPage with Scaffold
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin(BuildContext context) async {
    String enteredUsername = usernameController.text.trim();
    String enteredPassword = passwordController.text.trim();

    if (enteredUsername.isNotEmpty && enteredPassword.isNotEmpty) {
      if (enteredUsername == "admin" && enteredPassword == "abc@123") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(), // Navigate to your Home widget
          ),
        );
      } else {
        try {
          QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await FirebaseFirestore.instance.collection('Users').get();

          // Iterate through the documents in the 'Users' collection
          for (QueryDocumentSnapshot<Map<String, dynamic>> user
          in usersSnapshot.docs) {
            // Retrieve the username and password from the user document
            String storedUsername = user.data()['Username'];
            String storedPassword = user.data()['Password'];

            // Compare the entered username and password with the stored ones
            if (enteredUsername == storedUsername &&
                enteredPassword == storedPassword) {
              // Username and password match, proceed with login
              // For example, you can navigate to the dashboard page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Apiaries(userId: user.id), // Navigate to your Apiaries widget
                ),
              );
              return; // Exit the function since login is successful
            }
          }

          // If the loop completes without finding a match, show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid username or password.'),
            ),
          );
        } catch (e) {
          print("Error: $e");
          // Handle any errors that may occur during the process
        }
      }
    } else {
      // Show an error message if username or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both username and password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bee App'),
        backgroundColor: Color.fromARGB(255, 190, 93, 0),
      ),
      body: Container(
        color: Color.fromARGB(255,242,207,13),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Container(
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255,242,207,13),
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor:  Color.fromARGB(
                                      255, 248, 146, 48),
                                  radius: 40,
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                ),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: usernameController,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your username',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(
                                          255, 248, 146, 48),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color:Color.fromARGB(
                                            255, 248, 146, 48),
                                        width: 3,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(
                                            255, 248, 146, 48), // Change border color to red when focused
                                        width: 3,
                                      ),
                                    ),
                                    prefixIcon: IconTheme(
                                      data: IconThemeData(
                                        color: Color.fromARGB(
                                            255, 248, 146, 48),
                                      ),
                                      child: Icon(Icons.verified_user),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  controller: passwordController,
                                  autocorrect: true,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(
                                          255, 248, 146, 48),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(
                                            255, 248, 146, 48),
                                        width: 3,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color:Color.fromARGB(
                                            255, 248, 146, 48), // Change border color to red when focused
                                        width: 3,
                                      ),
                                    ),
                                    prefixIcon: IconTheme(
                                      data: IconThemeData(
                                        color: Color.fromARGB(
                                            255, 248, 146, 48),
                                      ),
                                      child: Icon(Icons.lock),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () => handleLogin(context), // Modify this line
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(
                                              255, 248, 146, 48),
                                        ),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'LOGIN',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          // Icon(
                                          //   Icons.arrow_forward,
                                          //   size: 25,
                                          //   color: Colors.white,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 100, // Set the width of the container
                                  height: 100, // Set the height of the container
                                  child: Image.asset(
                                    'assets/bee-hive.png', // Replace 'image_name.png' with the actual image asset path
                                    fit: BoxFit.cover, // Adjust how the image fits into the container
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
