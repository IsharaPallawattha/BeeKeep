import 'package:flutter/material.dart';
import 'hexagon_clipper.dart';

class InfoHexagon extends StatelessWidget {
  final String title;
  final String icon;
  final String value;

  const InfoHexagon({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Adjust margins as needed
      child: ClipPath(
        clipper: HexagonClipper(),
        child: Container(
          color: const Color.fromARGB(220, 248, 146, 48), // Set the background color with alpha value (opacity)
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  icon,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
