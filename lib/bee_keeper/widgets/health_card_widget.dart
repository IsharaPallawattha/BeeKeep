import 'package:flutter/material.dart';
import 'alert_cards.dart'; // Import the file where AlertCard is defined

class SquareCardHealth extends StatelessWidget {
  final List<String> prediction;

  const SquareCardHealth({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    String? imagePath;
    String? title;
    Color? col;
    if (prediction.isNotEmpty) {
      String result = prediction[0];
      if (result == "Unhealthy") {
        imagePath = 'assets/alert.png';
        title = 'Unhealthy Hive';
        col = const Color.fromARGB(255, 248, 146, 48);
      } else if (result == "Healthy") {
        imagePath = 'assets/check.png';
        title = 'Healthy Hive';
        col = Colors.green;
      }
    } else {
      imagePath = 'assets/oops.png';
      title = 'Sorry, Couldn\'t Load Data';
      col = Colors.red;
    }
    return AlertCard(imagePath:imagePath!, title:title!, col:col!); // Using AlertCard widget
  }
}
