import 'package:flutter/material.dart';
import 'alert_cards.dart';

class SquareCardHarvest extends StatelessWidget {
  final double? avgHarvestVal ;

  const SquareCardHarvest({super.key, this.avgHarvestVal});

  @override
  Widget build(BuildContext context) {
    String? imagePath;
    String? title;
    Color? col;
    if (avgHarvestVal != null) {
      if (avgHarvestVal! >= 14.00) {
        imagePath = 'assets/alert.png';
        title = 'Ready to Harvest';
        col = const Color.fromARGB(
            255, 248, 146, 48);
      } else {
        imagePath = 'assets/check.png';
        title = "Not Ready to Harvest";
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