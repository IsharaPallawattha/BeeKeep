
import 'package:flutter_application_2/login_page.dart';

// import 'add_user.dart';
import '../service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'apiaries.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/admin/pages/add_user.dart' as user_page;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  TextEditingController Usernamecontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  Stream? Userstream;

  getontoeload()async{
    Userstream=await DatabaseMethods().getUserDetails();
    setState(() {

    });
  }

  @override
  void initState() {
    getontoeload();
    super.initState();
  }

  Widget allUserDetails(){
    return StreamBuilder(
        stream: Userstream,
        builder: (context, AsyncSnapshot snapshot){
          return snapshot.hasData? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                DocumentSnapshot ds = snapshot.data!.docs[index];
                String documentId = ds.id;
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Username: "+ds["Username"],
                                  style: const TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Apiaries(userId: documentId,)));
                                  },
                                  child: const Icon(Icons.home,color:Color.fromARGB(255, 255, 101, 59),)),
                              const SizedBox(width: 10.0,),
                              GestureDetector(
                                  onTap: () {
                                    EditUserDetails(documentId);
                                    Namecontroller.text=ds["Name"];
                                    Usernamecontroller.text=ds["Username"];
                                    Passwordcontroller.text=ds["Password"];
                                    Phonecontroller.text=ds["Phone"];
                                    Emailcontroller.text=ds["Email"];
                                  },
                                  child: const Icon(Icons.edit,color:Color.fromARGB(255, 255, 101, 59),)),
                              const SizedBox(width: 10.0,),
                              GestureDetector(
                                  onTap: () async{
                                    await DatabaseMethods().deleteUserDetails(documentId);
                                  },
                                  child: const Icon(Icons.delete,color:Colors.black,))

                            ],
                          ),
                          Text("Password: "+ds["Password"],
                              style: const TextStyle(color: Color.fromARGB(255, 243, 33, 33),fontSize: 20.0,fontWeight: FontWeight.bold)),
                          Text("Name: "+ds["Name"],
                              style: const TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
                          Text("Phone Number: "+ds["Phone"],style: const TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
                          Text("Email: new@gmail.com"+ds["Email"],style: const TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
                        ],
                      ),  ),
                  ),
                );
              }):Container();
        });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const user_page.User())); //must check! maybe bc the user function is not created yet?

      },
      backgroundColor: const Color.fromARGB(255, 255, 193, 37),child: const Icon(Icons.add),),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin Page" ,
              style: TextStyle(
                  
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            
          ],
           

        ),
         actions: <Widget>[
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
         await FirebaseAuth.instance.signOut();
         Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const LoginPage()),);
      },
    ),
  ],
   backgroundColor: const Color.fromARGB(255, 255, 193, 37),
        ),
       body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/comb.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: Column(
              children: [
                Expanded(child: allUserDetails()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future EditUserDetails(String id)=> showDialog(context: context, builder: (context)=>AlertDialog(
    content:Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: const Icon(Icons.cancel)),
                const SizedBox(width: 60.0,),
                const Text(
                  "Edit",
                  style: TextStyle(
                      color: Color.fromARGB(255, 169, 158, 60),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Details",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 193, 37),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),
            const SizedBox(height: 20.0,),

            const Text("Username",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Usernamecontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20.0,),
            const Text("Password",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Passwordcontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20.0,),
            const Text("Name",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Namecontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20.0,),
            const Text("Phone Number",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Phonecontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20.0,),
            const Text("Email",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: const Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Emailcontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(child: ElevatedButton (onPressed: ()async{
              Map<String,dynamic>updateInfo={
                "Username":Usernamecontroller.text,
                "Password":Passwordcontroller.text,
                "Name":Namecontroller.text,
                "Phone":Phonecontroller.text,
                "Email":Emailcontroller.text,
              };
              await DatabaseMethods().updateUserDetails(id, updateInfo).then((value) {
                Navigator.pop(context);
              });
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, ),child: const Text("Update"),)),

          ],
        ),
      ),
    ),
  ));

}