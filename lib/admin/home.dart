
import 'user.dart';
import 'service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'apiaries.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  TextEditingController Usernamecontroller = new TextEditingController();
  TextEditingController Passwordcontroller = new TextEditingController();
  TextEditingController Namecontroller = new TextEditingController();
  TextEditingController Phonecontroller = new TextEditingController();
  TextEditingController Emailcontroller = new TextEditingController();
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
                  margin: EdgeInsets.only(bottom: 20),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Username: "+ds["Username"],
                                  style: TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Apiaries(userId: documentId,)));
                                  },
                                  child: Icon(Icons.home,color:const Color.fromARGB(255, 255, 101, 59),)),
                              SizedBox(width: 10.0,),
                              GestureDetector(
                                  onTap: () {
                                    EditUserDetails(documentId);
                                    Namecontroller.text=ds["Name"];
                                    Usernamecontroller.text=ds["Username"];
                                    Passwordcontroller.text=ds["Password"];
                                    Phonecontroller.text=ds["Phone"];
                                    Emailcontroller.text=ds["Email"];
                                  },
                                  child: Icon(Icons.edit,color:const Color.fromARGB(255, 255, 101, 59),)),
                              SizedBox(width: 10.0,),
                              GestureDetector(
                                  onTap: () async{
                                    await DatabaseMethods().deleteUserDetails(documentId);
                                  },
                                  child: Icon(Icons.delete,color:Colors.black,))

                            ],
                          ),
                          Text("Password: "+ds["Password"],
                              style: TextStyle(color: const Color.fromARGB(255, 243, 33, 33),fontSize: 20.0,fontWeight: FontWeight.bold)),
                          Text("Name: "+ds["Name"],
                              style: TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
                          Text("Phone Number: "+ds["Phone"],style: TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
                          Text("Email: new@gmail.com"+ds["Email"],style: TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold)),
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>User())); //must check! maybe bc the user function is not created yet?

      },child: Icon(Icons.add),),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin",
              style: TextStyle(
                  color: const Color.fromARGB(255, 169, 158, 60),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Page",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 193, 37),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],

        ),),
      body:Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0,top: 30.0),
        child:Column(
          children: [
            Expanded(child: allUserDetails()),
          ],
        ),
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
                    child: Icon(Icons.cancel)),
                SizedBox(width: 60.0,),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 169, 158, 60),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Details",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 193, 37),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),
            SizedBox(height: 20.0,),

            Text("Username",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Usernamecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Password",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Passwordcontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Name",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Namecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Phone Number",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Phonecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Email",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Emailcontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),
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
            },child: Text("Update"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, ),)),

          ],
        ),
      ),
    ),
  ));

}