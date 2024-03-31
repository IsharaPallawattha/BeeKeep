import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'apiaries.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: LoginPage(), // Wrap LoginPage with Scaffold
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
          // String storedUsername = 'user';
          // String storedPassword = 'password';

          print("sds$storedPassword");
          print("sds$enteredPassword");

          // Compare the entered username and password with the stored ones
          if (enteredUsername == storedUsername &&
              enteredPassword == storedPassword) {
            // Username and password match, proceed with login
            // For example, you can navigate to the dashboard page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Apiaries(userId: user.id)),
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
                    Color.fromARGB(255, 216, 184, 0),
                    Color.fromARGB(255, 216, 184, 0),
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
        border:
            Border.all(color: const Color.fromARGB(255, 65, 60, 60), width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person,
          color: Color.fromARGB(255, 65, 60, 60), size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color.fromARGB(255, 65, 60, 60)),
    );

    return TextField(
      style: const TextStyle(color: Color.fromARGB(255, 65, 60, 60)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 65, 60, 60)),
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
        foregroundColor: const Color.fromARGB(255, 241, 241, 241),
        backgroundColor: const Color.fromARGB(255, 65, 60, 60),
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
