import 'add_apiary.dart';
import 'service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'hives.dart';

class Apiaries extends StatefulWidget {
  final String userId; // Add userId parameter
  const Apiaries({Key? key, required this.userId}) : super(key: key);

  @override
  State<Apiaries> createState() => _ApiariesState();
}

class _ApiariesState extends State<Apiaries>{

  TextEditingController Namecontroller = new TextEditingController();
  TextEditingController Locationcontroller = new TextEditingController();

  Stream? Apiarystream;

  getontoeload() async {
    Apiarystream = await DatabaseMethods().getApiaryDetails(widget.userId); // Access userId from widget
    setState(() {

    });
  }

  @override
  void initState() {
    getontoeload();
    super.initState();
  }

  Widget allApiaryDetails(){
    return StreamBuilder(
        stream: Apiarystream,
        builder: (context, AsyncSnapshot snapshot){
          return snapshot.hasData? SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
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
                                    Flexible(
                                      child: Text(
                                        "Name: " + ds["name"],
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Hives(userId: widget.userId, apiaryId: documentId)));
                                      },
                                      child: Icon(
                                        Icons.more,
                                        color: const Color.fromARGB(255, 255, 101, 59),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    GestureDetector(
                                      onTap: () {
                                        EditApiaryDetails(widget.userId, documentId);
                                        Namecontroller.text = ds["name"];
                                        Locationcontroller.text = ds["location"];
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: const Color.fromARGB(255, 255, 101, 59),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    GestureDetector(
                                      onTap: () async {
                                        await DatabaseMethods().deleteApiaryDetails(widget.userId, documentId);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Location: "+ds["location"],
                                    style: TextStyle(color: const Color.fromARGB(255, 243, 33, 33),fontSize: 20.0,fontWeight: FontWeight.bold)),

                              ],
                            ),  ),
                        ),
                      );
                    }),
              ],
            ),
          ) : Container();
        });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Apiary(userId: widget.userId,))); //must check! maybe bc the user function is not created yet?

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
            Expanded(child: allApiaryDetails()),
          ],
        ),
      ),
    );
  }

  Future EditApiaryDetails(String userID, String apiaryID) => showDialog(context: context, builder: (context) => AlertDialog(
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
            Text("Location",style: TextStyle(color:Colors.black,fontSize: 15.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: Locationcontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),

            Center(child: ElevatedButton (onPressed: ()async{
              Map<String,dynamic>updateInfo={
                "name":Namecontroller.text,
                "location": Locationcontroller.text, // Fix Locationcontroller.text
              };
              await DatabaseMethods().updateApiaryDetails(userID, apiaryID, updateInfo).then((value) {
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