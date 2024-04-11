import '../service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User>{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add",
              style: TextStyle(
                  color: Color.fromARGB(255, 169, 158, 60),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Users",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 193, 37),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Username",style: TextStyle(color:Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0,),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text("Password",style: TextStyle(color:Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0,),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text("Name",style: TextStyle(color:Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0,),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text("Phone Number",style: TextStyle(color:Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0,),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text("Email",style: TextStyle(color:Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0,),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 40.0,),
              Center(
                child: ElevatedButton(
                  onPressed: ()async {
                    String id = randomAlphaNumeric(10);
                    Map<String, dynamic> userInfoMap = {
                      "Username": usernameController.text,
                      "Password": passwordController.text,
                      "Name": nameController.text,
                      "Phone": phoneController.text,
                      "Email": emailController.text
                    };

                    // Add the user details
                    bool success = await DatabaseMethods().addUserDetails(userInfoMap, id);

                    if (success) {
                      Fluttertoast.showToast(
                        msg: "User details added successfully!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green, // Change the background color to green for success
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Failed to add user details!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Set button color to yellow
                  ),
                  child: const Text("Add",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set text color to black
                    ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
