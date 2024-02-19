import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatelessWidget {
 List cateNames =[
  "Classes",
  "Category",
  "Course",
  "Book Store",
  "Live course",
  "LeaderBoard",
 ];

 List<Color> cateColors=[
  Color(0xffFFD3A5),
  Color.fromARGB(255, 168, 165, 255),
  Color.fromARGB(255, 165, 255, 165),
  Color.fromARGB(255, 255, 165, 216),
  Color.fromARGB(255, 165, 249, 255),
  Color.fromARGB(255, 68, 34, 179),
 ];

 List<Icon> cateIcons=[
  Icon(Icons.video_library,color: Colors.white,size:35),
  Icon(Icons.category,color: Colors.white,size:35),
  Icon(Icons.assignment,color: Colors.white,size:35),
  Icon(Icons.store,color: Colors.white,size:35),
  Icon(Icons.play_circle_fill,color: Colors.white,size:35),
  Icon(Icons.emoji_events,color: Colors.white,size:35),
  
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
                          image: AssetImage("https://i.postimg.cc/gcLV85qm/8bf50582-9fd1-49f5-b86a-01660327b3c5.jpg"),
                         
                        ),
                      )
                    ),
                      ],
                    ),
                  ],
                ),

                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}
 
