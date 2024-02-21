import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatelessWidget {
 List cateNames =[
  "Hive 1",
  "Hive 2",
  "Hive 3",
  "Hive 4",
  "Hive 5",
  "Hive 6",
 ];

 List<Color> cateColors=[
  Color.fromARGB(255, 107, 104, 30),
  Color.fromARGB(255, 107, 104, 30),
  Color.fromARGB(255, 107, 104, 30),
  Color.fromARGB(255, 107, 104, 30),
  Color.fromARGB(255, 107, 104, 30),
  Color.fromARGB(255, 107, 104, 30),
 ];

 List<Icon> cateIcons=[
  Icon(Icons.inventory_2,color: Colors.white,size:35),
  Icon(Icons.inventory_2,color: Colors.white,size:35),
  Icon(Icons.inventory_2,color: Colors.white,size:35),
  Icon(Icons.inventory_2,color: Colors.white,size:35),
  Icon(Icons.inventory_2,color: Colors.white,size:35),
  Icon(Icons.inventory_2,color: Colors.white,size:35),
  
 ];


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top:15,left:15,right:15,bottom:10),
                  width:MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3.32,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 236, 24, 1),
                   borderRadius:
                    BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),

                  //side nav 
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap:(){},
                          child:Icon(
                            Icons.sort,
                            color:Colors.white,
                            size:40,
                          ),
                        ),
                    Container(
                      height: 50,
                      width:50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage("https://cdn-icons-png.flaticon.com/512/1077/1077114.png"
                          ),
                         fit:BoxFit.cover,
                        ),
                      )
                    ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Liyana GAY",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        //SizedBox(height: 20),
                        
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      margin: EdgeInsets.only(top: 5,bottom:20),
                      width:MediaQuery.of(context).size.width,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: " Search here...",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity (0.5),
                          ),
                          prefixIcon: Icon(Icons.search, size:25),
                        ),
                      ),
                    ),
                  ],
                ),

                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.431,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 236, 24, 1),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:Container(
                height: MediaQuery.of(context).size.height/1.43,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
               /*    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ), */
                ),
                
                child:SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:EdgeInsets.only(top: 20, left: 15, right:15),
                      
                      child:Column(
                        children: [
                          GridView.builder(
                            itemCount: cateNames.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                            ),
                            itemBuilder: (context,index){
                              return Column(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: cateColors[index],
                                      shape:BoxShape.circle,
                                    ),
                                    child: cateIcons[index],
                                  
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    cateNames[index],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color:Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
 
