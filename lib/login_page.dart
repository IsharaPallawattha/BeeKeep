import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'apiaries.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  Future<void> handleLogin() async {
    String enteredUsername = usernameController.text.trim();
    String enteredPassword = passwordController.text.trim();

    if (enteredUsername.isNotEmpty && enteredPassword.isNotEmpty) {
      try {
        QuerySnapshot<Map<String, dynamic>> usersSnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

        // Iterate through the documents in the 'Users' collection
        for (QueryDocumentSnapshot<Map<String, dynamic>> user
        in usersSnapshot.docs) {
          // Retrieve the username and password from the user document
          String storedUsername = user.data()['Username'];
          String storedPassword = user.data()['Password'];

          print("sds"+storedPassword);
          print("sds"+enteredPassword);


          // Compare the entered username and password with the stored ones
          if (enteredUsername == storedUsername && enteredPassword == storedPassword) {
            // Username and password match, proceed with login
            // For example, you can navigate to the dashboard page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Apiaries()),
            );
            return; // Exit the function since login is successful
          }
        }

        // If the loop completes without finding a match, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password.'),
          ),
        );
      } catch (e) {
        print("Error: $e");
        // Handle any errors that may occur during the process
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        drawer: const Drawer(),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 240, 243, 33),
                    Color.fromARGB(255, 247, 255, 177),
                  ],
                ),
              ),
              child: _page(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 50),
              _inputField("Username", usernameController),
              const SizedBox(height: 20),
              _inputField("Password", passwordController, isPassword: true),
              const SizedBox(height: 50),
              _loginBtn(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        handleLogin();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.yellow,
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
