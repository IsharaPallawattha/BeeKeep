import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
        width:double.infinity,
        height: size.height,
        child:Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top:0,
              left:0,
              child:Image.network(""),
            ),
          ],
        ),
      ),
    );
  }
}