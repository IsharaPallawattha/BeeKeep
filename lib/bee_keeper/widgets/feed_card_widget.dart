import 'package:flutter/material.dart';
import 'alert_cards.dart';

class SquareCardFeed extends StatelessWidget {
  final double? avgRainVal;

  const SquareCardFeed({super.key, this.avgRainVal});

  @override
  Widget build(BuildContext context) {
    String? imagePath;
    String? title;
    Color? col;
    if (avgRainVal!= null) {
      if (avgRainVal! >= 50) {
        imagePath = 'assets/alert.png';
        title = 'Feeding Required';
        col = const Color.fromARGB(255, 248, 146, 48);
      } else {
        imagePath = 'assets/check.png';
        title = "No Feeding Required";
        col = Colors.green;
      }
    } else {
      imagePath = 'assets/oops.png';
      title = 'Sorry, Couldn\'t Load Data';
      col = Colors.red;
    }
    return AlertCard(imagePath:imagePath, title:title, col:col); // Using AlertCard widget
  }

}