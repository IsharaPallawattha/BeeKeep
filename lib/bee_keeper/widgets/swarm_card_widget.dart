import 'package:flutter/material.dart';
import 'alert_cards.dart';

class SquareCardSwarm extends StatelessWidget {
  final double? avgFreqVal;

  const  SquareCardSwarm({super.key, this.avgFreqVal});

  @override
  Widget build(BuildContext context) {
    String? imagePath;
    String? title;
    Color? col;
    if (avgFreqVal != null) {
      if (avgFreqVal! > 400) {
        imagePath = 'assets/alert.png';
        title = 'Swarming Detected';
        col = const Color.fromARGB(
            255, 248, 146, 48);
      } else {
        imagePath = 'assets/check.png';
        title = "No Swarming Detected";
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