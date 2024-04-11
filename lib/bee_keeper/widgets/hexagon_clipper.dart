import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    Path path = Path();
    path.moveTo(width / 4, 0);
    path.lineTo(width * 3 / 4, 0);
    path.lineTo(width, height / 2);
    path.lineTo(width * 3 / 4, height);
    path.lineTo(width / 4, height);
    path.lineTo(0, height / 2);
    path.lineTo(width / 4, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
