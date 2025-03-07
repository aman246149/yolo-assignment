import 'package:flutter/material.dart';

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;
    final curveHeight = height * 0.7;

    path.lineTo(0, height - curveHeight);

    // Create left curve with steeper angle
    path.quadraticBezierTo(
      width * 0.15,
      height - (curveHeight * 0.5),
      width * 0.35,
      height - (curveHeight * 0.85),
    );

    // Create center arch with more height
    path.quadraticBezierTo(
      width * 0.5,
      height - (curveHeight * 1.3),
      width * 0.65,
      height - (curveHeight * 0.85),
    );

    // Create right curve with steeper angle
    path.quadraticBezierTo(
      width * 0.85,
      height - (curveHeight * 0.5),
      width,
      height - curveHeight,
    );

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
